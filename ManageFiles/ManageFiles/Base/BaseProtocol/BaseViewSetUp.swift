//
//  BaseViewSetUp.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import Foundation
import UIKit

protocol BaseViewSetUp {
    func setupUI()
    func setupRX()
}

protocol SetupTableView {
    var tableView: UITableView { get set }
}
extension SetupTableView {
    
    func setupTableView<T: UITableViewCell>(delegate: UITableViewDelegate, name: T.Type) {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = delegate
        tableView.register(nibWithCellClass: T.self)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
}
