//
//  PictureOfTheDayDB.swift
//  APOD
//
//  Created by Nikita Elizarov on 03.02.2022.
//

import Foundation
import RealmSwift

class PictureOfTheDayDB: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var subtitle = ""
    @objc dynamic var date = ""
    @objc dynamic var author = ""
    @objc dynamic var mediaType = ""
    @objc dynamic var thumbnailURL = ""
    @objc dynamic var contentURL = ""

    override static func primaryKey() -> String? {
        "id"
    }
}
