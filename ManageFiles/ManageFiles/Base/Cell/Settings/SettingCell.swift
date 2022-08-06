//
//  SettingCell.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit

class SettingCell: UITableViewCell, BaseViewSetUp {
    
    private let settingView: SettingView = .loadXib()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
        self.setupRX()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SettingCell {
    func setupUI() {
        self.addSubview(settingView)
        self.settingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupRX() {
        
    }
    
    func radiusNormal() {
        self.settingView.radiusNormal()
    }
    
    func radiusBottom() {
        self.settingView.radiusBottom()
    }
    
    func radiusTop() {
        self.settingView.radiusTop()
    }
    
    func setValueSetting(model: BaseSettingModel) {
        self.settingView.setValueSetting(model: model)
    }
}
