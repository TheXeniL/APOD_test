//
//  URLRequestBuilderProtocol.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

protocol URLRequestBuilderProtocol {
    func makeURLRequest(from request: Request) throws -> URLRequest
}
