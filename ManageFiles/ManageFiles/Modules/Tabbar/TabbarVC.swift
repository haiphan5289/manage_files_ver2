//
//  TabbarVC.swift
//  ManageFiles
//
//  Created by haiphan on 05/08/2022.
//

import UIKit
import EasyBaseCodes

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
                vc.tabBarItem.title = ""
            }
        }
    }
    
}
