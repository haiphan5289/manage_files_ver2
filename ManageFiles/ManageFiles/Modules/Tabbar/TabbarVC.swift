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
        
        var title: String {
            switch self {
            case .home: return "Home"
            case .files: return "Files"
            case .center: return ""
            case .tools: return "Tools"
            case .setting: return "Settings"
            }
        }
        
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
        Ulitity.removeBorderTabbar(tabBar: tabBar)
        
        self.viewControllers = TabbarStyle.allCases.map { $0.viewcontroller }
        TabbarStyle.allCases.forEach { (type) in
            if let vc = self.viewControllers?[type.rawValue] {
                vc.tabBarItem.title = type.title
            }
        }
        self.setupIamge()
    }
    
    private func setupIamge() {
        let button = UIButton(type: .custom)
           var toMakeButtonUp = 40
           button.frame = CGRect(x: 0.0, y: 0.0, width: 65, height: 65)
//           button.setBackgroundImage(ADD, for: .normal)
//           button.setBackgroundImage(ADD, for: .highlighted)
        button.backgroundColor = .red
           let heightDifference: CGFloat = CGFloat(toMakeButtonUp)
           if heightDifference < 0 {
               button.center = tabBar.center
           } else {
               var center: CGPoint = tabBar.center
               center.y = center.y - heightDifference / 2.0
               button.center = center
           }
           view.addSubview(button)
    }
    
}
