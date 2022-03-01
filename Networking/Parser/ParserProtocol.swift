//
//  ParserProtocol.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

protocol ParserProtocol {
    func parse<T: Decodable>(_: T.Type, data: Data) throws -> T
}
