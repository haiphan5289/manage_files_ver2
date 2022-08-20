//
//  GlobalAppProtocol.swift
//  ManageFiles
//
//  Created by haiphan on 20/08/2022.
//

import Foundation
import EasyFiles
import Zip

protocol GlobalAppProtocol {}
extension GlobalAppProtocol {
    
    //MARK: ZIP ITEMS
    func unZipItems(sourceURL: URL, folderName: String, failure: (String) -> Void?) {
        var listName: [String] = []
        let destination = EasyFilesManage.shared.createURL(folder: folderName, name: "")
        do {
            _ = try Zip.unzipFile(sourceURL, destination: destination, overwrite: true, password: nil, progress: nil, fileOutputHandler: { unzippedFile in
                let name = EasyFilesManage.shared.getNameFolderToCompress(url: unzippedFile)
                
                listName.append(name)
            })
            if let index = listName.firstIndex(where: { $0.uppercased().contains("__MACOSX".uppercased()) }) {
                EasyFilesManage.shared.removeFolder(name: listName[index])
                listName.remove(at: index)
            }
            if let last = listName.last {
                var removeText = last
                if last.count > 0 {
                    removeText.removeLast()
                } else {
                    return
                }
                
                var isFolderExist: Bool = false
                
                GlobalApp.FolderName.allCases.forEach { type in
                    if type.rawValue.uppercased() == removeText.uppercased() {
                        isFolderExist = true
                    }
                }
                
                if !isFolderExist {
                    let folder = FolderModel(imgName: "ic_other_folder",
                                             url: EasyFilesManage.shared.createURL(folder: "", name: last),
                                             id: Date().convertDateToLocalTime().timeIntervalSince1970)
                    RealmManager.shared.editFolder(model: folder)
                }
                GlobalApp.shared.updateAgain.onNext(())
            }
        }
        catch {
          failure("Folder is empty")
        }
    }
    
    func zipItems(sourceURL: [URL], folderCompress: String) {
        let zipId = String(Int(Date().convertDateToLocalTime().timeIntervalSince1970))
        let name =  "\(folderCompress)" + "/" + "\(zipId)"
        do {
            _ = try Zip.quickZipFiles(sourceURL, fileName: name) // Zip
        }
        catch {
          print("Something went wrong")
        }
    }
    
    
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
