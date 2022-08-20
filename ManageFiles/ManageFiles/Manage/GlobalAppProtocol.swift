//
//  GlobalAppProtocol.swift
//  ManageFiles
//
//  Created by haiphan on 20/08/2022.
//

import Foundation
import EasyFiles

protocol GlobalAppProtocol {}
extension GlobalAppProtocol {
    
    
    
    //MARK: DUPLICATE ITEMS
    func duplicateItemHome(folderName: String, at srcURL: URL) async throws -> Result<URL, Error> {
        var  dstURL = EasyFilesManage.shared.createURL(folder: folderName,
                                                       name: "\(Int(Date().convertDateToLocalTime().timeIntervalSince1970))\(srcURL.getName())")
        if let imageType = EasyFilesManage.shared.detectFile(url: srcURL) {
            dstURL.appendPathExtension(imageType.value)
        }
        do {
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
            return .success(dstURL)
        } catch (let error) {
            return .failure(error)
        }
    }
}
