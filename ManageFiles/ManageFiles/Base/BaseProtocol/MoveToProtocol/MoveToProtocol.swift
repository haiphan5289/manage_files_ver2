//
//  MoveToProtocol.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//

import Foundation
import EasyFiles
import UIKit

protocol MoveToProtocol {}
extension MoveToProtocol {
    
    func moveToFiles(folder: FolderModel) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        let vc = FilesMenuVC.createVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.folder = folder
        topVC.present(vc, animated: true, completion: nil)
    }
    
    func moveToSort(sort: SortModel, delegate: SortDelegate) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        let vc = SortVC.createVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.sort = sort
        vc.delegate = delegate
        topVC.present(vc, animated: true, completion: nil)
    }
    
    func moveToFolder(url: URL) {
        if let topVC = GlobalCommon.topViewController(), url.hasDirectoryPath {
            let vc = FolderVC.createVC()
            let folderName = EasyFilesManage.shared.detectPathFolder(url: url)
            vc.folderName = folderName
            topVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func moveToActionFiles(url: URL) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        let vc = ActionFilesVC.createVC()
        vc.originURL = [url]
        topVC.navigationController?.pushViewController(vc)

    }
    
}
