
//
//  
//  NotePadVC.swift
//  ManageFiles
//
//  Created by haiphan on 21/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyFiles

class NotePadVC: BaseVC, MoveToProtocol {
    
    // Add here outlets
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    // Add here your view model
    private var viewModel: NotePadVM = NotePadVM()
    private let titleView: NavigationActionView = .loadXib()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeBorder(font: UIFont.systemFont(ofSize: 17),
                            bgColor: .white,
                            textColor: .black)
    }
}
extension NotePadVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        screenType = .action
        self.addViewNavigationBar(titleView: self.titleView)
        self.hideBackButton()
        self.titleView.delgate = self
        self.titleView.hidePlusButton()
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
extension NotePadVC: NavigationActionDelegate {
    func selectAction(action: NavigationActionView.Action) {
        switch action {
        case .back, .plus: break
        case .save:
            guard let title = self.tfName.text,
                  !title.isEmpty,
                  let textFile = self.tvContent.text else {
                self.showAlert(title: nil, message: "Vui lòng nhập tên")
                return
            }
            Task.init {
                do {
                    let result = try await EasyFilesManage.shared.write(text: "\(GlobalApp.FolderName.Trash.rawValue)/", nameFile: title + ".txt")
                    switch result {
                    case .success(let outputURL):
                        self.moveToActionFiles(url: [outputURL], status: .cloud, isNotePad: true)
                    case .failure(_): break
                    }
                } catch {
                    
                }
            }
            
        }
    }
    
    
}
