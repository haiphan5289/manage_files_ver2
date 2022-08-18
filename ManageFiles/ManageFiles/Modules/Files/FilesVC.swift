
//
//  
//  FilesVC.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyBaseCodes
import EasyFiles
import SnapKit

class FilesVC: BaseTabbarVC {
    
    // Add here outlets
    @IBOutlet weak var contentSearchView: UIView!
    @IBOutlet weak var contentTableView: UIView!
    // Add here your view model
    private var viewModel: FilesVM = FilesVM()
    private var sortModel = SortModel.valueDefault
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    
}
extension FilesVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .files
        self.contentSearchView.addSubview(self.searchView)
        self.searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.searchView.delegate = self
        
        self.contentTableView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        GlobalApp.shared.$files.map({ list in
            return EasyFilesManage.shared.sortDatasource(folders: list, sort: self.sortModel)
        })
            .bind(to: self.source).disposed(by: disposeBag)
    }
}
extension FilesVC: SearchViewDelegate {
    func searchText(text: String) {
        if text.isEmpty {
            GlobalApp.shared.updateAgain.onNext(())
        } else {
            let list = GlobalApp.shared.files.filter { $0.url.getName().uppercased().contains(text.uppercased()) }
            GlobalApp.shared.files = list
        }
    }
    
    func actionSort() {
        let vc = SortVC.createVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.sort = self.sortModel
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}
extension FilesVC: SortDelegate {
    func selectSort(sort: SortModel) {
        self.sortModel = sort
        GlobalApp.shared.updateAgain.onNext(())
        
    }
}
