//
//  Request.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

public protocol Request{
    var path: String { get }
    var method: HTTPMethod { get }
    var query: [String : String]? { get }
    var body: Encodable? { get }
    var headers: [String : String]? { get }
}
