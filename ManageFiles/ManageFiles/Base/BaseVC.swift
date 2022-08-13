//
//  BaseVC.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import UIKit
import SnapKit

class BaseVC: UIViewController {
    
    enum ScreenType {
        case tabbar, files, tools, setting, action
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
        case .action:
            self.navigationController?.isNavigationBarHidden = false
        }
        navigationBarCustom(font: UIFont.systemFont(ofSize: 17),
                            bgColor: .white,
                            textColor: .black,
                            isTranslucent: true)
    }
    
    func addViewNavigationBar(titleView: UIView) {
        self.navigationController?.navigationBar.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTitleView(titleView: UIView) {
        navigationItem.titleView = titleView
    }
    
    func navigationBarCustom(font: UIFont,
                             bgColor: UIColor,
                             textColor: UIColor,
                             isTranslucent: Bool = true) {
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barTintColor = bgColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor,
                                                                        NSAttributedString.Key.font: font]
        self.setupNavigationBariOS15(font: font,
                                     bgColor: bgColor,
                                     textColor: textColor,
                                     isTranslucent: isTranslucent)
    }
    
    func setupNavigationBariOS15(font: UIFont, bgColor: UIColor, textColor: UIColor, isTranslucent: Bool = true) {
        if #available(iOS 15.0, *) {
            let atts = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = atts
            appearance.backgroundColor = bgColor
            
            if let navBar = self.navigationController {
                let bar = navBar.navigationBar
                bar.standardAppearance = appearance
                bar.scrollEdgeAppearance = appearance
//                bar.compactScrollEdgeAppearance = appearance
            }
            
        }
    }
    
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}
