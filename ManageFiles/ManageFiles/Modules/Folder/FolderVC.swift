
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
    
    // Add here outlets
    @IBOutlet weak var contentTableView: UIView!
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
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        self.$sources.bind(to: self.source).disposed(by: disposeBag)
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
            self.moveToSort(sort: self.sortModel, delegate: self)
        }
    }
}
extension FolderVC: SortDelegate {
    func selectSort(sort: SortModel) {
        self.sortModel = sort
        self.folders()
    }
}
