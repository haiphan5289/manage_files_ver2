
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
import EasyFiles

protocol SortDelegate: AnyObject {
    func selectSort(sort: SortModel)
}

class SortVC: UIViewController {
    
    var delegate: SortDelegate?
    
    // Add here outlets
    @IBOutlet weak var stackView: UIStackView!
    
    // Add here your view model
    private var viewModel: SortVM = SortVM()
    var sort = SortModel.valueDefault
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer()
        self.view.addGestureRecognizer(tap)
        tap.rx.event
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        EasyFilesManage.Sort.allCases.forEach { type in
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
            sortView.setType(type: type)
            (type == self.sort.sort) ? sortView.showArrow() : sortView.hideArrow()
            
            let bt: UIButton = UIButton(type: .custom)
            v.addSubview(bt)
            bt.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    owner.dismiss(animated: true) {
                        let sort = SortModel(sort: type, isAscending: false)
                        owner.delegate?.selectSort(sort: sort)
                    }
                }.disposed(by: disposeBag)
            
            self.stackView.addArrangedSubview(v)
        }
        
    }
    
    private func setupRX() {
        // Add here the setup for the RX
    }
}
