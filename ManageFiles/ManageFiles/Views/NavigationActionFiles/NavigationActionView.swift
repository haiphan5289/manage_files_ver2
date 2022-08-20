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
    
    func setTitleSave(title: String) {
        self.bts[Action.save.rawValue].setTitle(title, for: .normal)
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
                    case .plus, .save:
                        owner.delgate?.selectAction(action: type)
                    }
                    
                }.disposed(by: disposeBag)
        }
    }
    
    func isShow() {
        self.bts[Action.save.rawValue].backgroundColor = Asset._0085Ff.color
        self.bts[Action.save.rawValue].setTitleColor(UIColor.white, for: .normal)
        self.bts[Action.save.rawValue].isEnabled = true
    }
    
    func notEmpty() {
        self.bts[Action.save.rawValue].isEnabled = true
        self.bts[Action.save.rawValue].backgroundColor = Asset._0085Ff.color
        self.bts[Action.save.rawValue].setTitleColor(UIColor.white, for: .normal)
    }
    
    func isEmpty() {
        self.bts[Action.save.rawValue].isEnabled = false
        self.bts[Action.save.rawValue].backgroundColor = Asset._0085Ff50.color
        self.bts[Action.save.rawValue].setTitleColor(UIColor.white, for: .normal)
    }
    
}
