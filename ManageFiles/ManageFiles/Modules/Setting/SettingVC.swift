
//
//  
//  SettingVC.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift

class SettingVC: BaseSetting {
    
    // Add here outlets
    @IBOutlet weak var contentTableView: UIView!
    
    // Add here your view model
    private var viewModel: SettingVM = SettingVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension SettingVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .setting
        self.contentTableView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        ReadJSON
            .shared
            .parseToDate(name: "Setting", type: "json")
            .decode(type: [BaseSettingModel].self, decoder: JSONDecoder())
            .witElementhUnretained(self)
            .bind(to: self.source)
            .disposed(by: disposeBag)
    }
}
