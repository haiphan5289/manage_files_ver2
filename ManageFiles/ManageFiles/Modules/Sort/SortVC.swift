
//
//  
//  SortVC.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift

class SortVC: UIViewController {
    
    enum SortType: Int, CaseIterable {
        case name, date, size, type
        
        var text: String {
            switch self {
            case .name: return "Name"
            case .date: return "Date"
            case .size: return "Size"
            case .type: return "File Type"
            }
        }
        
    }
    
    // Add here outlets
    @IBOutlet weak var stackView: UIStackView!
    
    // Add here your view model
    private var viewModel: SortVM = SortVM()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension SortVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        SortType.allCases.forEach { type in
            let v: UIView = UIView(frame: .zero)
            v.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
            
            let sortView: SortView = .loadXib()
            v.addSubview(sortView)
            sortView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
            }
            self.stackView.addArrangedSubview(v)
        }
        
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
