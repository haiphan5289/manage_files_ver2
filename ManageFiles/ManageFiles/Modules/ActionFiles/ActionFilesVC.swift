
//
//  
//  ActionFilesVC.swift
//  ManageFiles
//
//  Created by haiphan on 13/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyBaseCodes
import EasyFiles

class ActionFilesVC: BaseVC {
    
    struct SaveView {
        let view: CopyView
        let numberOffoldes: Int
    }
    
    // Add here outlets
    @IBOutlet weak var contentHeaderView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    private var saves: [SaveView] = []
    private var parentView: CopyView = CopyView(url: URL(fileURLWithPath: ""),
                                                numberOffoldes: 0,
                                                imgCheck: "img_check",
                                                imgArrowRight: Asset.imgArrowRight.image,
                                                imgDrop: Asset.imgDrop.image,
                                                icOtherFolder: Asset.imgFolder.image,
                                                lineColor: Asset.black10.color,
                                                folders: GlobalApp.shared.folders)
    private var selectFolder: String = ""
    // Add here your view model
    private var viewModel: ActionFilesVM = ActionFilesVM()
    private let titleView: NavigationActionView = .loadXib()
    private let headerView: FilesCellView = .loadXib()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationView()
    }
    
}
extension ActionFilesVC {
    
    private func setupNavigationView() {
        self.addViewNavigationBar(titleView: self.titleView)
        self.hideBackButton()
        self.titleView.delgate = self
        
        self.contentHeaderView.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        self.headerView.setValueActionView(value: 0)
        self.headerView.hideButonMore()
    }
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .action
        guard let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return
        }
        let appURL = URL(fileURLWithPath: documentDirectoryPath)
        self.getUrlOfFolder(url: appURL).forEach { [weak self] url in
            guard let wSelf = self else { return }
            wSelf.loadViews(url: url, numberOffoldes: ManageApp.shared.detectNumberofFolder(url: url)) { copyView in
                wSelf.stackView.addArrangedSubview(copyView)
            }
        }
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
    
    private func getUrlOfFolder(url: URL) -> [URL] {
        return ManageApp.shared.getfolders(url: url, text: "default.realm.management")
    }
    
    private func loadViews(url: URL, numberOffoldes: Int, comlention: (CopyView) -> Void) {
        let v: CopyView = CopyView(url: url,
                                   numberOffoldes: numberOffoldes,
                                   imgCheck: "img_check",
                                   imgArrowRight: Asset.imgArrowRight.image,
                                   imgDrop: Asset.imgDrop.image,
                                   icOtherFolder: Asset.imgFolder.image,
                                   lineColor: Asset.black10.color,
                                   folders: GlobalApp.shared.folders)
        v.actionTap = { [weak self] isShow in
            guard let wSelf = self else { return }
            wSelf.stackView.subviews.forEach { vi in
                guard let contentView = vi as? CopyView else { return }
                if v.url.absoluteString.uppercased().contains(contentView.url.absoluteString.uppercased()) {
                    if wSelf.parentView != contentView {
                        wSelf.parentView = contentView
                        wSelf.saves = []
                    }
                } else {
                    contentView.showExplainView(isHide: true)
                    contentView.removeSubviewStackView()
                    contentView.hideCheckImg()
                }
            }
            
            //Update saves
            var s = wSelf.saves
            wSelf.saves.enumerated().forEach { item in
                let save = item.element
                
                if save.numberOffoldes >= numberOffoldes {
                    save.view.showExplainView(isHide: true)
                    save.view.removeSubviewStackView()
                    save.view.hideCheckImg()
                    if let index = s.firstIndex(where: { $0.view == save.view }) {
                        s.remove(at: index)
                    }
                }
            }
            wSelf.saves = s
            
            if isShow {
                let save = SaveView(view: v, numberOffoldes: numberOffoldes)
                wSelf.saves.append(save)
                v.showExplainView(isHide: false)
                v.showCheckImg()
                wSelf.getUrlOfFolder(url: v.url).forEach { url in
                    wSelf.loadViews(url: url, numberOffoldes: ManageApp.shared.detectNumberofFolder(url: url)) { copyView in
                        v.addViewToStackExplain(copyView: copyView)
                    }
                }
                wSelf.selectFolder = ManageApp.shared.detectPathFolder(url: v.url)
                wSelf.titleView.isShow()
            } else {
                v.showExplainView(isHide: true)
                v.removeSubviewStackView()
                if let index = wSelf.saves.firstIndex(where: { $0.view == v }) {
                    wSelf.saves.remove(at: index)
                }

                let att = NSMutableAttributedString(string: ManageApp.shared.cutThePreviousFolder(url: v.url))
                let list = ManageApp.shared.rangeTexts(source: att, searchText: "/")
                if list.isEmpty {
                    wSelf.selectFolder  = ManageApp.shared.cutThePreviousFolder(url: v.url)
                    wSelf.titleView.notEmpty()
                } else {
                    wSelf.selectFolder  = ""
                    wSelf.titleView.isEmpty()
                }

            }
        }
        comlention(v)
    }
}
extension ActionFilesVC: NavigationActionDelegate {
    func selectAction(action: NavigationActionView.Action) {
        switch action {
        case .back:
            self.navigationController?.popViewController(animated: true, nil)
        case .save, .plus: break
        }
    }
}
