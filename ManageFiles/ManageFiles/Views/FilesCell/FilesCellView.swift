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
    @IBOutlet weak var bottomStackView: NSLayoutConstraint!
    @IBOutlet weak var leftStackView: NSLayoutConstraint!
    @IBOutlet weak var rightStackView: NSLayoutConstraint!
    @IBOutlet weak var topStackView: NSLayoutConstraint!
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
        self.hideButonMore()
    }
    
    func setValueAdd(model: BaseSettingModel) {
        if let img = model.icon {
            self.img.image = UIImage(named: img)
            self.lbTitle.text = model.name
            self.lbSubtitle.text = model.subName
        }
    }
    
    func hideButonMore() {
        self.btMore.isHidden = true
    }
    
    func setValueActionView(value: CGFloat) {
        let v = [self.bottomStackView,
                 self.topStackView,
                 self.leftStackView,
                 self.rightStackView]
        v.forEach { lb in
            lb?.constant = value
        }
    }
    
    func setValueBottom(value: CGFloat) {
        self.bottomStackView.constant = value
        self.leftStackView.constant = value
        self.rightStackView.constant = value
    }
    
    func setValueAction(folder: FolderModel) {
        self.loadTitle(folder: folder)
        self.lbSubtitle.text = "This Item will be save to"
    }
    
    func setValueFiles(folder: FolderModel) {
        self.loadTitle(folder: folder)
        
        if let name = folder.imgName {
            let count = ManageApp.shared.getItemsFolder(folder: name).count
            self.updateSubTitle(count: count)
        }
    }
    
    private func loadTitle(folder: FolderModel) {
        if let img = folder.imgName {
            self.lbTitle.text = folder.url.getName()
            self.img.image = UIImage(named: img)
        } else {
            self.lbTitle.text = "\(folder.url.getName()).\(folder.url.getType() ?? "")"
            ManageApp.shared.loadImage(imgThumbnail: img,
                                       lbName: lbTitle,
                                       file: folder)
            
        }
    }
    
    private func updateSubTitle(count: Int) {
        lbSubtitle.text = (count <= 0) ? "No Items" : "\(count) Items"
    }
    
}
