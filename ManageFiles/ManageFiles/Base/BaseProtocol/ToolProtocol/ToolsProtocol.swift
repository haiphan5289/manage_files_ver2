//
//  ToolsProtocol.swift
//  ManageFiles
//
//  Created by haiphan on 17/08/2022.
//

import Foundation
import VisionKit
import MobileCoreServices
import EasyBaseCodes

protocol ToolsProtocol {}
extension ToolsProtocol {
    func selectAction(type: ToolsVC.ToolsFile,
                      delegateCloud: UIDocumentPickerDelegate,
                      additionStatus: AdditionVC.AdditionStatus,
                      additionDelegate: AdditionDelegate?) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        switch type {
        case .importFiles:
            let types = [kUTTypeMovie, kUTTypeVideo, kUTTypeAudio, kUTTypeQuickTimeMovie, kUTTypeMPEG, kUTTypeMPEG2Video, kUTTypeGNUZipArchive, kUTTypeZipArchive, kUTTypePDF, kUTTypeImage, kUTTypeJPEG, kUTTypePNG, kUTTypeLivePhoto, kUTTypeHTML, kUTTypeXML]
            let typeCloud2 = ([kUTTypeMPEG, kUTTypeImage, kUTTypeJPEG, kUTTypePNG] as? [String]) ?? []
            let documentPicker =  UIDocumentPickerViewController(documentTypes: (additionStatus == .imageToPDF) ? typeCloud2 : ["public.item"], in: .import)
            documentPicker.delegate = delegateCloud
            documentPicker.allowsMultipleSelection = false
            
            topVC.present(documentPicker, animated: true, completion: nil)
        case .notePad:
            let vc = NotePadVC.createVC()
            topVC.navigationController?.pushViewController(vc, animated: true)
        case .videoPlayer:
            let vc = CameraVC.createVC()
            topVC.navigationController?.pushViewController(vc, animated: true)
        case .imageToPdf:
            let vc = AdditionVC.createVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = additionDelegate
            vc.additionStatus = .imageToPDF
            topVC.present(vc, animated: true, completion: nil)
        case .fileTransfer:
            let vc = TransferWifiVC.createVC()
            topVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
