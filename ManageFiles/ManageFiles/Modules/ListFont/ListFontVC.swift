
//
//  
//  ListFontVC.swift
//  ManageFiles
//
//  Created by haiphan on 05/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift

class ListFontVC: UIViewController {
    
    // Add here outlets
    
    // Add here your view model
    private var viewModel: ListFontVM = ListFontVM()
    
    @IBOutlet weak var regular: UILabel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension ListFontVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        print(regular.font.fontName)
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
