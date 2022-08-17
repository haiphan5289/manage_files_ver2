//
//  SortView.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//

import UIKit

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
    
    func setType(type: SortVC.SortType) {
        self.lbName.text = type.text
    }
}
