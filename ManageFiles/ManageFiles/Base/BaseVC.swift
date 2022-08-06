//
//  BaseVC.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit

class BaseVC: UIViewController {
    
    enum ScreenType {
        case tabbar, files, tools, setting
    }
    
    var screenType: ScreenType = .tabbar

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch screenType {
        case .tabbar, .files, .tools, .setting:
            self.navigationController?.isNavigationBarHidden = true
        }
    }

}
