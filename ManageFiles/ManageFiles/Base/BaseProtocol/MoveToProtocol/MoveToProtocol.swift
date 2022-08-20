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
    
    func moveToFiles(folder: FolderModel, delegate: FilesMenuDelegate) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        let vc = FilesMenuVC.createVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.folder = folder
        vc.delegate = delegate
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
    
    func moveToFolder(url: URL, delegate: UIDocumentInteractionControllerDelegate? = nil, folder: String? = nil) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        if url.hasDirectoryPath || !(folder?.isEmpty ?? false) {
            let vc = FolderVC.createVC()
            let folderName = EasyFilesManage.shared.detectPathFolder(url: url)
            vc.folderName = folderName
            if let folder = folder {
                vc.folderName = folder
            }
            topVC.navigationController?.pushViewController(vc, animated: true)
        } else {
            switch EasyFilesManage.shared.detectFile(url: url) {
            case .jpeg, .jpg, .m4a, .m4r, .mp3, .mp4, .png, .video, .wav, .pdf, .txt:
                let urlFile = URL(string: url.absoluteString)
                var documentInteractionController: UIDocumentInteractionController!
                documentInteractionController = UIDocumentInteractionController.init(url: urlFile!)
                documentInteractionController?.delegate = delegate
                documentInteractionController?.presentPreview(animated: true)
            case .zip:
                let folderName = EasyFilesManage.shared.getNameFolderToCompress(url: url)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    GlobalApp.shared.unZipItems(sourceURL: url, folderName: folderName ) { text in
                        topVC.showAlert(title: nil, message: text)
                    }
                }
            case .none: break
            }
        }
    }
    
    func moveToActionFiles(url: [URL], status: ActionFilesVC.ActionStatus) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        let vc = ActionFilesVC.createVC()
        vc.originURL = url
        vc.status = status
        topVC.navigationController?.pushViewController(vc)

    }
    
}
