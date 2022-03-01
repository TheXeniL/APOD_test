//
//  RegularRequest.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

public struct RegularRequest: Request {
    public let path: String
    public let method: HTTPMethod
    public var query: [String : String]?
    public var body: Encodable?
    public var headers: [String : String]?
    
    public init(
        path: String,
        method: HTTPMethod,
        query: [String : String]? = nil,
        body: Encodable? = nil,
        headers: [String : String]? = nil
    ) {
        self.path = path
        self.method = method
        self.query = query
        self.body = body
        self.headers = headers
    }
}
