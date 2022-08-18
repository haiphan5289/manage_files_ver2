//
//  SortView.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//

import UIKit
import EasyFiles

class SortView: UIView, BaseViewSetUp {

    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }

}
extension SortView {
    func setupUI() {
        
    }
    
    func setupRX() {
        
    }
    
    func hideArrow() {
        self.imgArrow.isHidden = true
    }
    
    func showArrow() {
        self.imgArrow.isHidden = false
    }
    
    func setType(type: EasyFilesManage.Sort) {
        self.lbName.text = type.text
    }
}
