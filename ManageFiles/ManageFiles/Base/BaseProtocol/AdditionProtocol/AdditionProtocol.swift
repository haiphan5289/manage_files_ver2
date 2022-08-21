//
//  AdditionProtocol.swift
//  ManageFiles
//
//  Created by haiphan on 10/08/2022.
//

import Foundation
import VisionKit
import MobileCoreServices
import EasyBaseCodes

protocol AdditionProtocol {}
extension AdditionProtocol {
    
    func selectAction(type: AdditionVC.Addtion,
                      delegateCloud: UIDocumentPickerDelegate,
                      delegatePhoto: (UIImagePickerControllerDelegate & UINavigationControllerDelegate),
                      delegateScan: VNDocumentCameraViewControllerDelegate) {
        guard let topVC = GlobalCommon.topViewController() else {
            return
        }
        switch type {
        case .importAdd:
            let types = [kUTTypeMovie, kUTTypeVideo, kUTTypeAudio, kUTTypeQuickTimeMovie, kUTTypeMPEG, kUTTypeMPEG2Video, kUTTypeGNUZipArchive, kUTTypeZipArchive, kUTTypePDF, kUTTypeImage, kUTTypeJPEG, kUTTypePNG, kUTTypeLivePhoto, kUTTypeHTML, kUTTypeXML]
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
            documentPicker.delegate = delegateCloud
            documentPicker.allowsMultipleSelection = false
            
            topVC.present(documentPicker, animated: true, completion: nil)
        case .photo:
            let img: UIImagePickerController = UIImagePickerController()
            img.allowsEditing = true
            img.sourceType = .photoLibrary
            img.delegate = delegatePhoto
            topVC.present(img, animated: true, completion: nil)
        case .scan:
            let scannerViewController = VNDocumentCameraViewController()
            scannerViewController.delegate = delegateScan
            topVC.present(scannerViewController, animated: true)
        case . text:
            topVC.dismiss(animated: true) {
                if let topvc = GlobalCommon.topViewController() {
                    let vc = NotePadVC.createVC()
                    topvc.navigationController?.pushViewController(vc, animated: true)
                }
            }
        case .camera, .folder: break
        }
    }
}
