//
//  ManageApp.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import Foundation
import EasyFiles
import EasyBaseCodes
import EasyBaseAudio
import RxSwift
import UIKit

final class GlobalApp: GlobalAppProtocol {
    
    enum FolderName: String, CaseIterable {
        case Archives, Documents, Folder, Images, Music, Others, Transfered, Trash, Videos
        
        var nameImage: String {
            switch self {
            case .Archives: return "img_archives"
            case .Documents: return "img_docs"
            case .Folder: return "img_folders"
            case .Images: return "img_images"
            case .Music: return "img_musics"
            case .Others: return "img_others"
            case .Transfered: return "img_transfered"
            case .Trash: return "img_trash"
            case .Videos: return "img_videos"
            }
        }
    }
    
    static var shared = GlobalApp()
    @VariableReplay var files: [FolderModel] = []
    @VariableReplay var folders: [FolderModel] = []
    @VariableReplay var homes: [FolderModel] = []
    let updateAgain: PublishSubject<Void> = PublishSubject.init()
    
    private let disposeBag = DisposeBag()
    private init() {}
    func start() {
        EasyFilesManage.shared.delegate = self
        self.setupValue()
        FolderName.allCases.forEach { name in
            EasyFilesManage.shared.createFolder(path: name.rawValue, success: nil, failure: nil)
        }
        
        if !RealmManager.shared.getFolders().map({ $0.imgName }).contains(FolderName.Archives.nameImage) {
            self.setValueDefault()
        }
    }
    
    private func setupValue() {
        let get = Observable.just(RealmManager.shared.getFolders())
        let update = NotificationCenter
            .default
            .rx
            .notification(NSNotification.Name(PushNotificationKeys.addedFolder.rawValue))
            .map { _ in RealmManager.shared.getFolders() }
        let delete = NotificationCenter
            .default
            .rx
            .notification(NSNotification.Name(PushNotificationKeys.deleteFolder.rawValue))
            .map { _ in RealmManager.shared.getFolders() }
        let updateAgain = self.updateAgain
            .map { _ in RealmManager.shared.getFolders() }
        Observable.merge(get, update, delete, updateAgain)
            .witElementhUnretained(self)
            .bind { list in
                self.folders = list
                self.files = list
                var homesList: [FolderModel] = []
                homesList += EasyFilesManage.shared.getDirectory()
                
                list
                    .filter({ folder in
                        let folderName = EasyFilesManage.shared.detectPathFolder(url: folder.url)
                        let isExist = (folderName.uppercased().contains(FolderName.Trash.rawValue.uppercased()))
                        return  !isExist
                    })
                    .forEach { folder in
                    let folderName: String = EasyFilesManage.shared.detectPathFolder(url: folder.url)
                    let n = folderName.count
                    if folderName.index(folderName.startIndex, offsetBy: n, limitedBy: folderName.endIndex) != nil {
                        let files = EasyFilesManage.shared.getItemsFolder(folder: folderName)
                            .filter({ !$0.hasDirectoryPath })
                            .map { url -> FolderModel in
                                return FolderModel(imgName: nil,
                                                   url: url,
                                                   id: Date().convertDateToLocalTimeNew().timeIntervalSince1970)
                            }
                        homesList += files
                    }
                }
                self.homes = homesList
                
        }.disposed(by: disposeBag)
    }

    private func setValueDefault() {
        let icons = FolderName.allCases.map { $0.nameImage }
        let folders = FolderName.allCases.map { $0.rawValue }
        EasyFilesManage.shared.defaultValueFolders(icons: icons, folders: folders)
    }
    
}
extension GlobalApp: ManageAppDelegate {
    func updateFirstApp(folders: [FolderModel]) {
        folders.forEach { folder in
            RealmManager.shared.editFolder(model: folder)
        }
    }
    
    func pinHomes(pins: [FolderModel]) {
        
    }
    
    
    func callAgain() {
        
    }
    
    func updateOrInsertConfig(folder: FolderModel) {
        
    }
    
    func deleteFolder(folder: FolderModel) {
        
    }
    
    func zip(sourceURL: [URL], nameZip: String) {
        
    }
    
    
}

extension Date {
    func convertDateToLocalTimeNew() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self)!
    }
}
