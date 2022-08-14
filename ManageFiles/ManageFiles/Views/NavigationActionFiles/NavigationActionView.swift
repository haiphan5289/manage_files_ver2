//
//  NavigationActionView.swift
//  ManageFiles
//
//  Created by haiphan on 13/08/2022.
//

import UIKit
import RxSwift

protocol NavigationActionDelegate: AnyObject {
    func selectAction(action: NavigationActionView.Action )
}

class NavigationActionView: UIView, BaseViewSetUp {
    
    enum Action: Int, CaseIterable {
        case back, plus, save
    }
    
    var delgate: NavigationActionDelegate?
    
    @IBOutlet var bts: [UIButton]!
    
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }
}
extension NavigationActionView {
    
    func setupUI() {
        
    }
    
    func setupRX() {
        Action.allCases.forEach { type in
            let bt = self.bts[type.rawValue]
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    owner.delgate?.selectAction(action: type)
                }.disposed(by: disposeBag)
        }
    }
    
}
