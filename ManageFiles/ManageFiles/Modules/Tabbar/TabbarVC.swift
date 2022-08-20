//
//  TabbarVC.swift
//  ManageFiles
//
//  Created by haiphan on 05/08/2022.
//

import UIKit
import EasyBaseCodes
import SnapKit
import RxSwift

class TabbarVC: UITabBarController, MoveToProtocol {
    
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
        
        var iconSelect: UIImage? {
            switch self {
            case .home: return Asset.icTbSelectedHome.image
            case .files: return Asset.icTbSelectedFolders.image
            case .center: return nil
            case .tools: return Asset.icTbSelectedTools.image
            case .setting: return Asset.icTbSelectedSettings.image
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .home: return Asset.icTabbarHome.image
            case .files: return Asset.icTabbarFolders.image
            case .center: return nil
            case .tools: return Asset.icTabbarTools.image
            case .setting: return Asset.icTabbarSettings.image
            }
        }
        
        var viewcontroller: UIViewController {
            switch self {
            case .home:
                return HomeVC.createVC()
            case .files:
                return FilesVC.createVC()
            case .center:
                return HomeVC.createVC()
            case .tools:
                return ToolsVC.createVC()
            case .setting:
                return SettingVC.createVC()
            }
            
        }
    }

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GlobalCommon.removeBorderTabbar(tabBar: self.tabBar)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let listTabbar = self.tabBar.items else {
            return
        }
        
        listTabbar.enumerated().forEach { (tabbar) in
            if let type = TabbarStyle(rawValue: tabbar.offset) {
                if tabbar.element == item {
                    tabbar.element.image = type.iconSelect
                } else {
                    tabbar.element.image = type.icon
                }
            }
        }
    }

}
extension TabbarVC {
    
    private func setupUI() {
        UITabBar.appearance().tintColor = Asset._0085Ff.color
        UITabBar.appearance().barTintColor = .white
        self.viewControllers = TabbarStyle.allCases.map { $0.viewcontroller }
        TabbarStyle.allCases.forEach { (type) in
            if let vc = self.viewControllers?[type.rawValue] {
                vc.tabBarItem.title = type.title
                vc.tabBarItem.image = (type == TabbarStyle.home) ? type.iconSelect : type.icon
            }
        }
        if let list = self.tabBar.items {
            list[TabbarStyle.center.rawValue].isEnabled = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.setupIamge()
        }
    }
    
    private func setupIamge() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 56, height: 56)
        button.setBackgroundImage(Asset.imgHomeButton.image, for: .normal)
        var center: CGPoint = tabBar.center
        center.y = tabBar.frame.origin.y
        button.center = center
        view.addSubview(button)
        button.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                guard let topController = GlobalCommon.topViewController() else {
                    return
                }
                let vc = AdditionVC.createVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                vc.delegate = self
                topController.present(vc, animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
    
    func moveToActionFiles(url: URL) {
        self.moveToActionFiles(url: [url], status: .cloud)

    }
    
}
extension TabbarVC: AdditionDelegate {
    func moveToAction(url: URL) {
        self.moveToActionFiles(url: url)
    }
    
}
