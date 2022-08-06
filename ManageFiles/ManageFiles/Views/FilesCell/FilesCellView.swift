//
//  FilesCellView.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import RxSwift
import EasyFiles

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
    
    func setupUI() {
        
    }
    
    func setupRX() {
        
    }
    
    func setValueTools(folder: FolderModel, toolFile: ToolsVC.ToolsFile) {
        self.lbTitle.text = toolFile.title
        self.lbSubtitle.text = toolFile.subTitle
        if let img = folder.imgName {
            self.img.image = UIImage(named: img)
        }
        self.btMore.isHidden = true
    }
    
    func setValueFiles(folder: FolderModel) {
        if let img = folder.imgName {
            self.lbTitle.text = folder.url.getName()
            self.img.image = UIImage(named: img)
        } else {
            self.lbTitle.text = "\(folder.url.getName()).\(folder.url.getType() ?? "")"
            ManageApp.shared.loadImage(imgThumbnail: img,
                                       lbName: lbTitle,
                                       file: folder)
            
        }
        
        if let name = folder.imgName {
            let count = ManageApp.shared.getItemsFolder(folder: name).count
            self.updateSubTitle(count: count)
        }
    }
    
    private func updateSubTitle(count: Int) {
        lbSubtitle.text = (count <= 0) ? "No Items" : "\(count) Items"
    }
    
}
