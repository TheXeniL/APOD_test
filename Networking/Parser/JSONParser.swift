//
//  JSONParser.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

struct JSONParser: ParserProtocol {
    private let decoder = JSONDecoder()

    func parse<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        do {
            return try self.decoder.decode(T.self, from: data)
        } catch {
            throw RequestError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))
        }
    }
}
