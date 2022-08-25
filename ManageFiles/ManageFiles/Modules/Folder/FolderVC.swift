
//
//  
//  FolderVC.swift
//  ManageFiles
//
//  Created by haiphan on 18/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyFiles

class FolderVC: BaseTabbarVC {
    
    enum Action: Int, CaseIterable {
        case delete, move, copy, duplicate, compress
    }
    
    enum CellStatus {
        case single, multi
    }
    
    // Add here outlets
    @IBOutlet weak var contentTableView: UIView!
    @IBOutlet var bts: [UIButton]!
    @IBOutlet weak var actionView: UIView!
    @VariableReplay private var sources: [FolderModel] = []
    private let titleView: NavigationSearchView = .loadXib()
    // Add here your view model
    private var viewModel: FolderVM = FolderVM()
    private var sortModel = SortModel.valueDefault
    
    
    var folderName: String?
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationView()
    }
    
}
extension FolderVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .folder
        self.contentTableView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(16)
        }
        self.folders()
        self.navigationController?.removeViewController(ActionFilesVC.self)
        self.navigationController?.removeViewController(TransferWifiVC.self)
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        self.$sources.bind(to: self.source).disposed(by: disposeBag)
        Action.allCases.forEach { type in
            let bt = self.bts[type.rawValue]
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    guard let indexs = owner.tableView.indexPathsForSelectedRows else {
                        return
                    }
                    let urls = indexs.map { $0.row }.map { owner.source.value.safe[$0] }.map { $0?.url }.compactMap { $0 }
                    switch type {
                    case .delete:
                        EasyFilesManage.shared.moveToItem(at: urls, folderName: GlobalApp.FolderName.Trash.rawValue + "/") {
                            
                        } failure: { msg in
                            self.showAlert(title: nil, message: msg)
                        }
                    case .copy, .move:
                        owner.moveToActionFiles(url: urls, status: ( type == .copy ) ? .copy : .move )
                    case .compress:
                        if let f = owner.folderName {
                            GlobalApp.shared.zipItems(sourceURL: urls, folderCompress: f)
                        }
                    case .duplicate:
                        if let f = owner.folderName {
                            urls.forEach { url in
                                Task.init {
                                    do {
                                        _ = try await GlobalApp.shared.duplicateItemHome(folderName: f, at: url)
                                        owner.cellStatus = .single
                                        owner.actionView.isHidden = true
                                        owner.folders()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                            
                        }
                    }
                    owner.cellStatus = .single
                    owner.actionView.isHidden = true
                    owner.folders()
                }.disposed(by: disposeBag)
        }
    }
    
    private func folders() {
        if let name = self.folderName {
            self.titleView.setName(name: name)
            self.sources = EasyFilesManage.shared.getItemsFolder(folder: name)
                .map({ url in
                if url.hasDirectoryPath {
                    return FolderModel(imgName: "ic_other_folder",
                                       url: url,
                                       id: Date().convertDateToLocalTime().timeIntervalSince1970)
                }
                return FolderModel(imgName: nil, url: url, id: Date().convertDateToLocalTime().timeIntervalSince1970)
            })
        }
        self.sortAgain(sort: self.sortModel)
    }
    
    private func sortAgain(sort: SortModel) {
        self.sortModel = sort
        self.sources = EasyFilesManage.shared.sortDatasource(folders: self.sources, sort: sort)
    }
    
    private func setupNavigationView() {
        self.addViewNavigationBar(titleView: self.titleView)
        self.hideBackButton()
        self.titleView.delegate = self
    }
}
extension FolderVC: NavigationSearchDelegate {
    func selectAction(action: NavigationSearchView.Action) {
        switch action {
        case .back, .search: break
        case .more:
            let multiSelect: MultiSelectView = .loadXib()
            multiSelect.show()
            multiSelect.delegate = self
        }
    }
}
extension FolderVC: SortDelegate {
    func selectSort(sort: SortModel) {
        self.sortModel = sort
        self.folders()
    }
}
extension FolderVC: MultiSelectViewDelegate {
    func selectAction(action: MultiSelectView.Action) {
        switch action {
        case .multiSelect:
            actionView.isHidden = false
            cellStatus = .multi
        case .sort: self.moveToSort(sort: self.sortModel, delegate: self)
        }
    }
    
}
