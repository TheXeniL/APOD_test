//
//  APICall.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Networking

public protocol APICall {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String]? { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}

extension APICall {
    func makeRegularRequest() -> Request {
        RegularRequest(
            path: path,
            method: method,
            query: queryParameters,
            body: body,
            headers: headers
        )
    }
}
