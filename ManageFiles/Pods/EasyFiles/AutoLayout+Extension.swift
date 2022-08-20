//
//  AutoLayout+Extension.swift
//  ManageFiles
//
//  Created by haiphan on 14/08/2022.
//

import Foundation
import UIKit

public extension UIView {
    static var isAddHeight: Bool = false
    static var isAdWidth: Bool = false
    static var isTopArea: Bool = false
    static var isBottomArea: Bool = false
    static var isLeftArea: Bool = false
    static var isRightArea: Bool = false
    func addHeight() -> Self {
        Self.isAddHeight = true
        return self
    }
    func addWidth() -> Self {
        Self.isAdWidth = true
        return self
    }
    func addTopArea() -> Self {
        Self.isTopArea = true
        return self
    }
    func addBottomArea() -> Self {
        Self.isBottomArea = true
        return self
    }
    func addLeftArea() -> Self {
        Self.isLeftArea = true
        return self
    }
    func addRightArea() -> Self {
        Self.isRightArea = true
        return self
    }
    
    func addValueConstraint(value: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if Self.isAddHeight {
            self.heightAnchor.constraint(equalToConstant: value).isActive = true
            Self.isAddHeight = false
        }
        if Self.isAdWidth {
            self.widthAnchor.constraint(equalToConstant: value).isActive = true
            Self.isAdWidth = false
        }
    }
    
    func addValueArea(view: UIView? = nil, value: CGFloat = 0) {
        guard let v = self.getViewLayout(view: view) else {
            return
        }
        
        if Self.isTopArea {
            self.topAnchor.constraint(equalTo: v.topAnchor, constant: value).isActive = true
            Self.isTopArea = false
        }
        if Self.isBottomArea {
            self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: value).isActive = true
            Self.isBottomArea = false
        }
        if Self.isLeftArea {
            self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: value).isActive = true
            Self.isLeftArea = false
        }
        if Self.isRightArea {
            self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: -value).isActive = true
            Self.isRightArea = false
        }
    }
    
    private func  getViewLayout(view: UIView? = nil) -> UIView? {
        guard var v: UIView = self.superview else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let vi = view {
            v = vi
        }
        return v
    }
    
    func addEdges(view: UIView? = nil) {
        guard let v = self.getViewLayout(view: view) else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: v.topAnchor, constant: 0),
            self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0),
            self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0)
        ])
    }
}
