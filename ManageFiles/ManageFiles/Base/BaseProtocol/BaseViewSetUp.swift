//
//  BaseViewSetUp.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import Foundation
import UIKit
import EasyBaseAudio

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
protocol SetupBaseCollection {}
extension SetupBaseCollection {
    
    func setupCollectionView<T: UICollectionViewCell>(collectionView: UICollectionView,
                                                 delegate: UICollectionViewDelegate,
                                                 name: T.Type) {
        collectionView.delegate = delegate
        collectionView.register(nibWithCellClass: T.self)
    }
    
}
