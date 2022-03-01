//
//  NetworkingProtocol.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation
import Combine

public protocol NetworkingProtocol: AnyObject {
    func execute<T: Decodable>(_: T.Type, request: Request) -> AnyPublisher<T,Error>
    func execute(request: Request) -> AnyPublisher<Data, Error>
}
