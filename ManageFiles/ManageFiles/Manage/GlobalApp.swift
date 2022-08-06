//
//  ManageApp.swift
//  ManageFiles
//
//  Created by haiphan on 06/08/2022.
//

import Foundation
import EasyFiles
import EasyBaseCodes
import RxSwift
import UIKit

final class GlobalApp {
    
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
    
    private let disposeBag = DisposeBag()
    private init() {}
    func start() {
        ManageApp.shared.delegate = self
        self.setupValue()
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
        Observable.merge(get, update, delete)
            .withUnretained(self)
            .bind { item in
                let list = item.1
                self.files = list
        }.disposed(by: disposeBag)
        
        if !RealmManager.shared.getFolders().map({ $0.imgName }).contains(FolderName.Archives.nameImage) {
            self.setValueDefault()
        }
    }
    

    
    private func setValueDefault() {
        let icons = FolderName.allCases.map { $0.nameImage }
        let folders = FolderName.allCases.map { $0.rawValue }
        ManageApp.shared.defaultValueFolders(icons: icons, folders: folders)
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
