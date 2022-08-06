//
//  BaseTabbarVC.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import EasyFiles
import EasyBaseCodes
import RxSwift
import RxCocoa

class BaseTabbarVC: BaseVC {

    let tableView: UITableView = UITableView(frame: .zero, style: .plain)
    let source: BehaviorRelay<[FolderModel]> = BehaviorRelay.init(value: [])
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenType = .tabbar
        self.setupUI()
        self.setupRX()
    }

}
extension BaseTabbarVC {
    
    private func setupUI() {
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        self.tableView.register(nibWithCellClass: FilesCell.self)
    }
    
    private func setupRX() {
        self.source
            .bind(to: tableView.rx.items(cellIdentifier: FilesCell.identifier, cellType: FilesCell.self)) {(row, element, cell) in
                
            }.disposed(by: disposeBag)
    }
    
}
extension BaseTabbarVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
