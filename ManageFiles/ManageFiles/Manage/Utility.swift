//
//  Utility.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import Foundation
import UIKit

public struct GlobalCommon {
    
     static func topMostController() -> UIViewController? {
      if var topController: UIViewController = UIApplication.shared.keyWindow?.rootViewController {
        while (topController.presentedViewController != nil) {
          topController = topController.presentedViewController!
        }
        return topController
      }
      return nil
    }
    
    static public func removeBorderTabbar(tabBar: UITabBar) {
        tabBar.backgroundColor = UIColor.white
        // Removing the upper border of the UITabBar.
        //
        // Note: Don't use `tabBar.clipsToBounds = true` if you want
        // to add a custom shadow to the `tabBar`!
        //
        if #available(iOS 13, *) {
            // iOS 13:
            let appearance = tabBar.standardAppearance
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            tabBar.standardAppearance = appearance
        } else {
            // iOS 12 and below:
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
    }
}
