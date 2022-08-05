//
//  TabbarVC.swift
//  ManageFiles
//
//  Created by haiphan on 05/08/2022.
//

import UIKit
import EasyBaseCodes
import SnapKit

class TabbarVC: UITabBarController {
    
    enum TabbarStyle: Int, CaseIterable {
        case home, files, center, tools, setting
        
        var viewcontroller: UIViewController {
            return HomeVC.createVC()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

}
extension TabbarVC {
    
    private func setupUI() {
        self.viewControllers = TabbarStyle.allCases.map { $0.viewcontroller }
        TabbarStyle.allCases.forEach { (type) in
            if let vc = self.viewControllers?[type.rawValue] {
                vc.tabBarItem.title = "Home"
            }
        }
        self.setupIamge()
    }
    
    private func setupIamge() {
        guard let view = self.tabBar.items?[3].value(forKey: "view") as? UIView else  { return }
        
        let imgNewFeatures: UIImageView = UIImageView(frame: .zero)
        imgNewFeatures.backgroundColor = .red
        let frame = view.frame
        self.view.bringSubviewToFront(imgNewFeatures)
        self.view.addSubview(imgNewFeatures)
        
        let lastPoint = frame.origin.x + (frame.size.width / 2)
        // layout for new features
        //let originX = lastPoint - Constant.widthIamge + Constant.dispaceImageToTrailing
        
        //layout for new face
        let originX = lastPoint - (50 / 2)
        imgNewFeatures.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(originX)
            make.bottom.equalToSuperview().inset(self.tabBar.frame.height)
            make.height.equalTo(36)
            make.width.equalTo(50)
        }
    }
    
}
