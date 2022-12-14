//
//  RealmModel.swift
//  KFC
//
//  Created by Dong Nguyen on 12/12/19.
//  Copyright © 2019 TVT25. All rights reserved.
//

import Foundation
import RealmSwift
import EasyFiles

class FolderRealm: Object {
    @objc dynamic var data: Data? = nil
    @objc dynamic var id: Double = 0

    init(model: FolderModel) {
        super.init()
        do {
            self.data = try model.toData()
            self.id = model.id
        } catch {
            print("\(error.localizedDescription)")
        }
        

    }
    required init() {
        super.init()
    }
}
