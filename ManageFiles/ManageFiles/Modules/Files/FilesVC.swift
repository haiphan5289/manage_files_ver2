
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
import SnapKit

class FilesVC: BaseTabbarVC {
    
    // Add here outlets
    @IBOutlet weak var contentSearchView: UIView!
    @IBOutlet weak var contentTableView: UIView!
    private let searchView: SearchView = .loadXib()
    // Add here your view model
    private var viewModel: FilesVM = FilesVM()
    
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
        
        self.contentTableView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        GlobalApp.shared.$files.bind(to: self.source).disposed(by: disposeBag)
        
        self.source
            .witElementhUnretained(self)
            .bind { list in
                print("======= Files \(list.count)")
            }.disposed(by: disposeBag)
    }
}
