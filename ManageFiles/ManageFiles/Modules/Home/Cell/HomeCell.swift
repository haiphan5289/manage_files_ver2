//
//  HomeCell.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//

import UIKit

class HomeCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension HomeCell {
    
    func setValueAdd(type: ToolsVC.ToolsFile) {
        self.lbName.text = type.title
        self.img.image = UIImage(named: type.imgStr)
    }
    
}
