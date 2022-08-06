//
//  FilesCellView.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import RxSwift

class FilesCellView: UIView, BaseViewSetUp {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var btMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }
}
extension FilesCellView {
    
    internal func setupUI() {
        
    }
    
    internal func setupRX() {
        
    }
    
}
