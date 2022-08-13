
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

class ActionFilesVC: BaseVC {
    
    // Add here outlets
    
    // Add here your view model
    private var viewModel: ActionFilesVM = ActionFilesVM()
    private let titleView: NavigationActionView = .loadXib()
    
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
    }
    
    private func setupUI() {
        // Add here the setup for the UI
        self.screenType = .action
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
