//
//  SettingView.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import EasyBaseCodes

class SettingView: UIView, BaseViewSetUp {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgButton: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }

    
}
extension SettingView {
    
    func setupUI() {
        
    }
    
    func setupRX() {
        
    }
    
    func radiusNormal() {
        self.containerView.clipsToBounds = true
        self.containerView.cornerRadius = 0
    }
    
    func radiusBottom() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.setCornerRadius(corner: .verticalBot, radius: 8)
    }
    
    func radiusTop() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.setCornerRadius(corner: .verticalTop, radius: 8)
    }
    
    func setValueSetting(model: BaseSettingModel) {
        if let icon = model.icon {
            img.image = UIImage(named: icon)
            lbTitle.text = model.name
        }
        imgButton.isHidden = true
    }
}
