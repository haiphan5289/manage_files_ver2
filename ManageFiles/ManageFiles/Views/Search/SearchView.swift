//
//  SearchView.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import RxSwift

protocol SearchViewDelegate: AnyObject {
    func actionSort()
    func searchText(text: String)
}

class SearchView: UIView, BaseViewSetUp {

    @IBOutlet weak var btSort: UIButton!
    @IBOutlet weak var leftStackView: NSLayoutConstraint!
    @IBOutlet weak var leadStackView: NSLayoutConstraint!
    @IBOutlet weak var tfSearch: UITextField!
    var delegate: SearchViewDelegate?
    
    private let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupRX()
    }
}
extension SearchView {
    
    func setupUI() {
        
    }
    
    func setupRX() {
        self.btSort
            .rx
            .tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.delegate?.actionSort()
            }.disposed(by: disposeBag)
        
        self.tfSearch.rx.text.orEmpty
            .withUnretained(self)
            .bind { owner, text in
                owner.delegate?.searchText(text: text)
            }.disposed(by: disposeBag)
    }
    
    func setValueConstrait(value: CGFloat) {
        let v = [leadStackView, leadStackView]
        v.forEach { v in
            v?.constant = value
        }
    }
    
    func hideSort() {
        self.btSort.isHidden = true
    }
    
}
