
//
//  
//  HomeVC.swift
//  ManageFiles
//
//  Created by haiphan on 05/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift

class HomeVC: UIViewController {
    
    // Add here outlets
    
    // Add here your view model
    private var viewModel: HomeVM = HomeVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension HomeVC {
    
    private func setupUI() {
        // Add here the setup for the UI
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
