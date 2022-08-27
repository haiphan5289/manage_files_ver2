
//
//  
//  INAPPVC.swift
//  ManageFiles
//
//  Created by haiphan on 27/08/2022.
//
//
import UIKit
import RxCocoa
import RxSwift
import EasyBaseCodes
import SwiftyStoreKit
import SVProgressHUD

protocol INAPPVCDelegate: AnyObject {
    func actionDissmiss()
}

enum PaymentInApp: Int, CaseIterable {
    case week
    case month
    case year
    
    var text: String {
        switch self {
        case .week:
            return "Weekly"
        case .month:
            return "Monthly"
        case .year:
            return "Yearly"
        }
    }
}

enum ProductID: String, CaseIterable {
    case yearly = "com.recorderyear1"
    case monthly = "com.recordermonth1"
    case weekly = "com.recorderweek1"
    
    var text: String {
        switch self {
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        case .yearly:
            return "Yearly"
        }
    }
    
    var index: Int {
        switch self {
        case .weekly:
            return 2
        case .monthly:
            return 1
        case .yearly:
            return 0
        }
    }
    
    var textValue: String {
        switch self {
        case .weekly:
            return "Week"
        case .monthly:
            return "Month"
        case .yearly:
            return "Year"
        }
    }
    
//    var valuePrenium: INAPPVC.InAppSegment {
//        switch self {
//        case .weekly: return INAPPVC.InAppSegment.week
//        case .monthly: return INAPPVC.InAppSegment.month
//        case .yearly: return INAPPVC.InAppSegment.year
//        default: return INAPPVC.InAppSegment.year
//        }
//    }
    
}

class INAPPVC: UIViewController {
    
    var delegate: INAPPVCDelegate?
    // Add here outlets
    @IBOutlet var bts: [UIButton]!
    @IBOutlet var views: [UIView]!
    @IBOutlet var imgs: [UIImageView]!
    @IBOutlet var lbs: [UILabel]!
    @IBOutlet weak var btDismiss: UIButton!
    @IBOutlet weak var btContinue: UIButton!
    
    // Add here your view model
    private var viewModel: INAPPVM = INAPPVM()
    private var selectAction: BehaviorRelay<ProductID> = BehaviorRelay.init(value: .yearly)
    private var products: [SKProductModel] = []
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupRX()
    }
    
}
extension INAPPVC {
    
    private func setupUI() {
        // Add here the setup for the UI
        InAppPerchaseManager.shared.requestProducts { [weak self] isSuccess, skProducts in
            guard let wSelf = self else { return }
            DispatchQueue.main.async {
                if isSuccess, let sk = skProducts, sk.count >= 3 {
                    var skProduct: [SKProductModel] = []
                    sk.forEach { item in
                        let m = SKProductModel(productID: item.productIdentifier, price: item.price)
                        skProduct.append(m)
                    }
                    wSelf.products = skProduct.sorted(by: { sk1, sk2 in
                        return (sk1.price as Decimal) < (sk2.price as Decimal)
                    })
                } else {
                    wSelf.products = GlobalApp.shared.listRawSKProduct()
                }
                
                wSelf.products.forEach { product in
                    guard let type = ProductID(rawValue: product.productID) else {
                        return
                    }
                    switch type {
                    case .yearly:
                        wSelf.lbs[type.index].text = "7 days free trial then $\(product.price) / year"
                    case .monthly:
                        wSelf.lbs[type.index].text = "3 days free trial then $\(product.price) / month"
                    case .weekly:
                        wSelf.lbs[type.index].text = "3 days free trial then $\(product.price) / week"
                    }
                    
                }
            }
        }
    }
    
    private func setupRX() {
        // Add here the setup for the RX
        ProductID.allCases.forEach { type in
            let bt = self.bts[type.index]
            bt.rx.tap
                .withUnretained(self)
                .bind { owner, _ in
                    owner.selectAction.accept(type)
                }.disposed(by: disposeBag)
        }
        
        self.btDismiss.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        self.selectAction
            .withUnretained(self)
            .bind { owner, type in
                owner.views.forEach { v in
                    v.layer.borderColor = Asset.f1F1F1.color.cgColor
                }
                owner.imgs.forEach { img in
                    img.image = Asset.icRadioOff.image
                }
                owner.imgs[type.index].image = Asset.icRadioOn.image
                owner.views[type.index].layer.borderColor = Asset._0085Ff.color.cgColor
            }.disposed(by: disposeBag)
        
        self.btContinue.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                if let f = owner.products.first(where: { $0.productID == owner.selectAction.value.rawValue }) {
                    owner.subscriptionAction(productId: f.productID)
                }
            }.disposed(by: disposeBag)
        
    }
    
    
    func restoreInApp() {
        if (InAppPerchaseManager.shared.canMakePurchase()) {
            InAppPerchaseManager.shared.restoreCompletedTransactions()
        }
    }
    
    func subscriptionAction(productId: String) {
        //self.showLoading()
        SVProgressHUD.show()
        SwiftyStoreKit.purchaseProduct(productId, atomically: true) { [weak self] (result) in
            guard let `self` = self else { return }
            //self.hideLoading()
            switch result {
            case .success(_):
                Configuration.joinPremiumUser(join: true)
                self.showAlert(title: "Successful", message: "Successful") { [weak self] in
                    guard let wSelf = self else { return }
                    wSelf.dismiss(animated: true, completion: { [weak self] in
                        guard let wSelf = self else { return }
                        wSelf.delegate?.actionDissmiss()
                    })
                    SVProgressHUD.dismiss()
                }
            case .error(_):
                self.showAlert(title: "Cannot subcribe", message: "Cannot subcribe")
                SVProgressHUD.dismiss()
            }
        }
        
    }
    
}
