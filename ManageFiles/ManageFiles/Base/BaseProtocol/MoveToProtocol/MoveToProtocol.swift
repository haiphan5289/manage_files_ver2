//
//  MoveToProtocol.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//

import Foundation

protocol MoveToProtocol {}
extension MoveToProtocol {
    
    func moveToActionFiles(url: URL) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        let vc = ActionFilesVC.createVC()
        vc.originURL = [url]
        topVC.navigationController?.pushViewController(vc)

    }
    
}
