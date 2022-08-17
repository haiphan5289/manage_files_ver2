//
//  Array+Extension.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//

import Foundation
import UIKit

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }

        return self[index]
    }
}
