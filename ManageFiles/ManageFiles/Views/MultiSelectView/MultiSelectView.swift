//
//  MultiSelectView.swift
//  ManageFiles
//
//  Created by haiphan on 22/08/2022.
//

import UIKit
import RxSwift

protocol MultiSelectViewDelegate: AnyObject {
    func selectAction(action: MultiSelectView.Action)
}

class MultiSelectView: UIView, BaseViewSetUp {
    
    struct Constant {
        static let xShadow: CGFloat = 0
        static let yShadow: CGFloat = 4
        static let spreadShadow: CGFloat = -6
        static let blur: CGFloat = 54
    }
    
    enum Action: Int, CaseIterable {
        case sort, multiSelect
    }
    
    weak var delegate: MultiSelectViewDelegate?
    
    @IBOutlet var bts: [UIButton]!
    
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupRX()
    }

}
extension MultiSelectView {
    func setupUI() {
        self.layer.applySketchShadow(color: Asset.black60.color,
                                     alpha: 1,
                                     x: Constant.xShadow,
                                     y: Constant.yShadow,
                                     blur: Constant.blur,
                                     spread: Constant.spreadShadow)
    }
    
    func setupRX() {
        Action.allCases.forEach { type in
            let bt = self.bts[type.rawValue]
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    owner.removeFromSuperview()
                    owner.delegate?.selectAction(action: type)
                }.disposed(by: disposeBag)
        }
    }
    
    func show() {
        guard let vc = GlobalCommon.topViewController() else {
            return
        }
        vc.view.addSubview(self)
        self.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(vc.view.safeAreaLayoutGuide.snp.top).inset(10)
            make.width.equalTo(243)
            make.height.equalTo(156)
        }
        vc.view.bringSubviewToFront(self)
        
    }
}
