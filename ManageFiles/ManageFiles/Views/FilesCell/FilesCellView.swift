//
//  FilesCellView.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import RxSwift
import EasyFiles
import RxCocoa

protocol FileCellDelegate: AnyObject {
    func selectAction(action: FilesCellView.Action)
}

class FilesCellView: UIView, BaseViewSetUp {

    enum Action: Int, CaseIterable {
        case more, drop
    }
    
    weak var delegate: FileCellDelegate?
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var bottomStackView: NSLayoutConstraint!
    @IBOutlet weak var leftStackView: NSLayoutConstraint!
    @IBOutlet weak var rightStackView: NSLayoutConstraint!
    @IBOutlet weak var topStackView: NSLayoutConstraint!
    @IBOutlet var bts: [UIButton]!
    
    private let disposeBag = DisposeBag()
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
        Action.allCases.forEach { type in
            let bt = self.bts[type.rawValue]
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    owner.delegate?.selectAction(action: type)
                }.disposed(by: disposeBag)
        }
    }
    
    func setTitleUrl(url: URL) {
        self.lbTitle.text = url.getName()
        self.lbTitle.adjustsFontSizeToFitWidth = true
        self.lbTitle.minimumScaleFactor = 0.5
    }
    
    func setValueHome(folder: FolderModel) {
        self.loadTitle(folder: folder)
        self.lbSubtitle.text = folder.url.getSubURL()
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
    
    func showbtDrop() {
        self.bts[Action.drop.rawValue].isHidden = false
    }
    
    func hideButonMore() {
        self.bts[Action.more.rawValue].isHidden = true
    }
    
    func updateLbSub(url: URL) {
        let atr = NSMutableAttributedString.init()
        let attr1: [NSMutableAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let str1 = NSAttributedString(string: "This item will be save to", attributes: attr1)
        atr.append(str1)
        let attr2: [NSMutableAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: Asset._0085Ff.color]
        let str2 = NSAttributedString(string: " \(url.getName())", attributes: attr2)
        atr.append(str2)
        self.lbSubtitle.attributedText = atr
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
    
    func setValueFilesMenu() {
        
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
            let count = EasyFilesManage.shared.getItemsFolder(folder: name).count
            self.updateSubTitle(count: count)
        }
    }
    
    private func loadTitle(folder: FolderModel) {
        if let img = folder.imgName {
            self.lbTitle.text = folder.url.getName()
            self.img.image = UIImage(named: img)
        } else {
            self.lbTitle.text = "\(folder.url.getName()).\(folder.url.getType() ?? "")"
            EasyFilesManage.shared.loadImage(imgThumbnail: img,
                                       lbName: lbTitle,
                                       file: folder)
            
        }
    }
    
    private func updateSubTitle(count: Int) {
        lbSubtitle.text = (count <= 0) ? "No Items" : "\(count) Items"
    }
    
}
