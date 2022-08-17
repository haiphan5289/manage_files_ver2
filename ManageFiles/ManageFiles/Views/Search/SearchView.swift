//
//  SearchView.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit

class SearchView: UIView, BaseViewSetUp {

    @IBOutlet weak var leftStackView: NSLayoutConstraint!
    @IBOutlet weak var leadStackView: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }
}
extension SearchView {
    
    func setupUI() {
        
    }
    
    func setupRX() {
        
    }
    
    func setValueConstrait(value: CGFloat) {
        let v = [leadStackView, leadStackView]
        v.forEach { v in
            v?.constant = value
        }
    }
    
}
