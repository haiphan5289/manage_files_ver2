
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

class HomeVC: BaseTabbarVC {
    
    // Add here outlets
    @IBOutlet weak var contentTableView: UIView!
    
    // Add here your view model
    private var viewModel: HomeVM = HomeVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension HomeVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.contentTableView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        self.source
            .witElementhUnretained(self)
            .bind { list in
                print("======= Home \(list.count)")
            }.disposed(by: disposeBag)
    }
}
