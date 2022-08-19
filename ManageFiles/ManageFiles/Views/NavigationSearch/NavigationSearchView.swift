//
//  NavigationSearchView.swift
//  ManageFiles
//
//  Created by haiphan on 19/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol NavigationSearchDelegate: AnyObject {
    func selectAction(action: NavigationSearchView.Action)
}

class NavigationSearchView: UIView, BaseViewSetUp {
    
    enum Action: Int, CaseIterable {
        case back, search, more
    }
    
    weak var delegate: NavigationSearchDelegate?
    @IBOutlet var bts: [UIButton]!
    @IBOutlet weak var lbName: UILabel!
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }
}
extension NavigationSearchView {
    
    func setupUI() {
        
    }
    
    func setupRX() {
        Action.allCases.forEach { type in
            let bt = self.bts[type.rawValue]
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    switch type {
                    case .back:
                        if let topVC = GlobalCommon.topViewController() {
                            topVC.navigationController?.popViewController()
                        }
                    case .more, .search:
                        owner.delegate?.selectAction(action: type)
                    }
                }.disposed(by: disposeBag)
        }
    }
    
    func setName(name: String) {
        self.lbName.text = name
    }
    
}
