//
//  RealmManager.swift
//  APOD
//
//  Created by Nikita Elizarov on 03.02.2022.
//

import Foundation
import RealmSwift

final class RealmManager: RealmManagerProtocol {
    var localStorage: Realm?

    init() { openRealm() }

    private func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localStorage = try Realm()
        } catch {
            fatalError("Failed initializing Realm DB")
        }
    }
}
