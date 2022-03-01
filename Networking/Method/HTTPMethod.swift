//
//  HTTPMethod.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

public enum HTTPMethod: String, Decodable {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case update = "UPDATE"
    case put = "PUT"
    case patch = "PATCH"
}
