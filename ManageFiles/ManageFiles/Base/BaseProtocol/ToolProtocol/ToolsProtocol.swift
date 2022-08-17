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
                      delegateCloud: UIDocumentPickerDelegate) {
        guard let topVC = GlobalCommon.topMostController() else {
            return
        }
        switch type {
        case .importFiles:
            let types = [kUTTypeMovie, kUTTypeVideo, kUTTypeAudio, kUTTypeQuickTimeMovie, kUTTypeMPEG, kUTTypeMPEG2Video, kUTTypeGNUZipArchive, kUTTypeZipArchive, kUTTypePDF, kUTTypeImage, kUTTypeJPEG, kUTTypePNG, kUTTypeLivePhoto, kUTTypeHTML, kUTTypeXML]
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
            documentPicker.delegate = delegateCloud
            documentPicker.allowsMultipleSelection = false
            
            topVC.present(documentPicker, animated: true, completion: nil)
        case .notePad, .fileTransfer, .imageToPdf, .videoPlayer: break
        }
    }
}