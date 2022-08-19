
//
//  
//  FilesMenuVC.swift
//  ManageFiles
//
//  Created by haiphan on 19/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyBaseCodes
import EasyFiles

class FilesMenuVC: UIViewController {
    
    enum Action: Int, CaseIterable {
        case info, rename, compress, duplicate, quickView, copy, move, share, delete
    }
    
    enum FolderStatus {
        case fix, folder, files
    }
    
    // Add here outlets
    var folder: FolderModel?
    @IBOutlet weak var heightBottom: NSLayoutConstraint!
    @IBOutlet weak var contentFileCellView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var views: [UIView]!
    @IBOutlet var bts: [UIButton]!
    private let fileCellView: FilesCellView = .loadXib()
    
    // Add here your view model
    private var viewModel: FilesMenuVM = FilesMenuVM()
    var FolderStatus: FolderStatus = .folder
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension FilesMenuVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        heightBottom.constant = GetHeightSafeArea.shared.getHeight(type: .bottom)
        contentView.layer.setCornerRadius(corner: .verticalTop, radius: 20)
        
        self.contentFileCellView.addSubview(self.fileCellView)
        self.fileCellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview().inset(24)
        }
        fileCellView.setValueBottom(value: 0)
        fileCellView.hideButonMore()
        fileCellView.showbtDrop()
        if let f = self.folder {
            fileCellView.setValueHome(folder: f)
        }
        fileCellView.delegate = self
        
        switch self.FolderStatus {
        case .files: break
        case .fix:
            let v = [views[Action.rename.rawValue], views[Action.quickView.rawValue], views[Action.move.rawValue], views[Action.share.rawValue], views[Action.delete.rawValue] ]
            v.forEach { v in
                v.isHidden = true
            }
        case .folder:
            let v = [views[Action.quickView.rawValue], views[Action.share.rawValue] ]
            v.forEach { v in
                v.isHidden = true
            }
        }
        
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
extension FilesMenuVC: FileCellDelegate {
    func selectAction(action: FilesCellView.Action) {
        self.dismiss(animated: true, completion: nil)
    }
}
