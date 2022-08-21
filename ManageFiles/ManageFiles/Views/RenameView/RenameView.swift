//
//  RenameView.swift
//  ManageFiles
//
//  Created by haiphan on 21/08/2022.
//

import UIKit
import RxSwift
import EasyFiles

protocol RenameViewDelegate: AnyObject {
    func update()
}

class RenameView: UIView, BaseViewSetUp {
    
    enum RenameStatus {
        case rename, create
    }
    
    enum Action: Int, CaseIterable {
        case cancel, save
    }
    var delegate: RenameViewDelegate?
    var ranmeStatus: RenameStatus = .rename
    var folderName: String?
    @IBOutlet var bts: [UIButton]!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var btSave: UIButton!
    var url: URL?
    @IBOutlet weak var lbTitle: UILabel!
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }
    
}
extension RenameView {
    
    func setupUI() {
        makeTitle(folderName: "Folder 14")
    }
    
    func setupRX() {
        Action.allCases.forEach { type in
            let bt = self.bts[type.rawValue]
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    switch type {
                    case .save:
                        guard let inputURL = owner.url,
                              let new = owner.tfName.text,
                              !new.isEmpty,
                              let topVC = GlobalCommon.topMostController() else { return }
                        
                        switch owner.ranmeStatus {
                        case .rename:
                            if inputURL.hasDirectoryPath {
                                let oldPath = EasyFilesManage.shared.detectPathFolder(url: inputURL)
                                let previousPath  = EasyFilesManage.shared.removePreviousFolder(url: inputURL)
                                let newPath = previousPath + new
                                EasyFilesManage.shared.changefile(old: oldPath, new: newPath) { err in
                                    DispatchQueue.main.async {
                                        topVC.showAlert(title: nil, message: err)
                                    }
                                }
                            } else {
                                Task.init {
                                    do {
                                        let folder = EasyFilesManage.shared.getNameFolderToCompress(url: inputURL)
                                        let newPath = folder + new
                                        let result = try await EasyFilesManage.shared.onlyChangeFile(old: inputURL, new: newPath)
                                        switch result {
                                        case .success:
                                            DispatchQueue.main.async {
                                                owner.removeFromSuperview()
                                                GlobalApp.shared.updateAgain.onNext(())
                                            }
                                        case .failure(let err):
                                            topVC.showAlert(title: nil, message: err.localizedDescription)
                                        }
                                    } catch let err{
                                        topVC.showAlert(title: nil, message: err.localizedDescription)
                                    }
                                }
                                
                            }
                        case .create:
                            let folderName = EasyFilesManage.shared.detectPathFolder(url: inputURL)
                            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                            var imagesDirectoryPath: String = documentDirectoryPath?.appending("/\(folderName)/\(new)") ?? ""
                            if folderName.isEmpty || folderName == "//" {
                                imagesDirectoryPath = documentDirectoryPath?.appending("/\(new)") ?? ""
                            }
                            
                            EasyFilesManage.shared.createInFolder(imagesDirectoryPath: imagesDirectoryPath) { outputURL in
                                EasyFilesManage.shared.createFoldertoRealm(url: outputURL, imgName: "ic_other_folder")
                                owner.delegate?.update()
                                owner.removeFromSuperview()
                            } failure: { text in
                                topVC.showAlert(title: nil, message: text)
                                
                            }
                        }
                    case .cancel:
                        owner.removeFromSuperview()
                    }
                    
                }.disposed(by: disposeBag)
        }
    }
    
    func setValue(url: URL, folderName: String) {
        self.url = url
        self.folderName = folderName
        self.makeTitle(folderName: folderName)
        
    }
    
    func makeTitle(folderName: String) {
        let att: NSMutableAttributedString = NSMutableAttributedString()
        
        let attr1: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.myMediumSystemFont(ofSize: 15),
                                                    NSAttributedString.Key.foregroundColor: UIColor.black ]
        let str1: NSAttributedString = NSAttributedString(string: (self.ranmeStatus == .rename) ? "Rename" : "Create new folder in" ,attributes: attr1)
        att.append(str1)
        let attr2: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.myMediumSystemFont(ofSize: 15),
                                                    NSAttributedString.Key.foregroundColor: Asset._0085Ff.color ]
        let str2: NSAttributedString = NSAttributedString(string: " \(folderName)", attributes: attr2)
        att.append(str2)
        lbTitle.attributedText = att
    }
    
    func show() {
        guard let topVC = GlobalCommon.topMostController() else {
            return
        }
        topVC.view.addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
