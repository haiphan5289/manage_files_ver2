
//
//  
//  InfoVC.swift
//  ManageFiles
//
//  Created by haiphan on 21/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
//import EasyBaseCodes
import EasyFiles
import Kingfisher

class InfoVC: UIViewController {
    
    enum View: Int, CaseIterable {
        case name, size, create, format
    }
    
    // Add here outlets
    var folder: FolderModel?
    @IBOutlet weak var heightBottom: NSLayoutConstraint!
    @IBOutlet weak var contentFileCellView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var lbs: [UILabel]!
    private let fileCellView: FilesCellView = .loadXib()
    // Add here your view model
    private var viewModel: InfoVM = InfoVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension InfoVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        self.heightBottom.constant = GetHeightSafeArea.shared.getHeight(type: .bottom)
        self.contentView.layer.setCornerRadius(corner: .verticalTop, radius: 20)
        
        self.contentFileCellView.addSubview(self.fileCellView)
        self.fileCellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview().inset(24)
        }
        fileCellView.setValueBottom(value: 0)
        fileCellView.hideButonMore()
        fileCellView.showbtDrop()
        if let f = self.folder {
            fileCellView.setValueFiles(folder: f)
            self.lbs[View.name.rawValue].text = f.url.getName()
            self.lbs[View.size.rawValue].text = "\(f.url.getSizeURL() ?? "") MB"
            self.lbs[View.create.rawValue].text = f.url.getCreateDateString()
            self.lbs[View.format.rawValue].text = f.url.getType()
        }
        fileCellView.delegate = self
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
extension InfoVC: FileCellDelegate {
    func selectAction(action: FilesCellView.Action) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

