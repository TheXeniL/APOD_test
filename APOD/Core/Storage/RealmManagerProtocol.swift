//
//  RealmManagerProtocol.swift
//  APOD
//
//  Created by Nikita Elizarov on 03.02.2022.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol: AnyObject {
    var localStorage: Realm? { get }
}
