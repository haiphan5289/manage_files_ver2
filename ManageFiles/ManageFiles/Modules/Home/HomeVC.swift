
//
//  
//  HomeVC.swift
//  ManageFiles
//
//  Created by haiphan on 05/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyBaseCodes
import EasyFiles

class HomeVC: BaseTabbarVC,
              SetupBaseCollection,
              ToolsProtocol,
              MoveToProtocol {
    
    // Add here outlets
    @IBOutlet weak var contentTableView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contentSearchView: UIView!
    // Add here your view model
    private var viewModel: HomeVM = HomeVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GlobalApp.shared.updateAgain.onNext(())
    }
    
}
extension HomeVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .home
        self.contentTableView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.setupCollectionView(collectionView: self.collectionView,
                                 delegate: self,
                                 name: HomeCell.self)
        self.contentSearchView.addSubview(self.searchView)
        self.searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.searchView.delegate = self
        self.searchView.setValueConstrait(value: 33)
        self.searchView.hideSort()
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        GlobalApp
            .shared
            .$homes
            .map({ list in
                let sort = SortModel.valueDefault
                return EasyFilesManage.shared.sortDatasource(folders: list, sort: sort)
            })
            .bind(to: self.source)
            .disposed(by: disposeBag)
        
        Observable.just(ToolsVC.ToolsFile.allCases)
            .bind(to: self.collectionView.rx.items(cellIdentifier: HomeCell.identifier,
                                                   cellType: HomeCell.self)) { row, data, cell in
                cell.setValueAdd(type: data)
            }.disposed(by: disposeBag)
        
        self.collectionView
            .rx
            .itemSelected
            .withUnretained(self)
            .bind { owner, idx in
                let type = ToolsVC.ToolsFile.allCases[idx.row]
                owner.selectAction(type: type, delegateCloud: owner)
            }.disposed(by: disposeBag)
        
    }
}
extension HomeVC: SearchViewDelegate {
    func actionSort() {
        
    }
    
    func searchText(text: String) {
        if text.isEmpty {
            GlobalApp.shared.updateAgain.onNext(())
        } else {
            let list = GlobalApp.shared.homes.filter { $0.url.getName().uppercased().contains(text.uppercased()) }
            GlobalApp.shared.homes = list
        }
    }
}
extension HomeVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let first = urls.first else {
            return
        }
        self.moveToActionFiles(url: first)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
