//
//  Client.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation
import Combine

public final class Client: NetworkingProtocol {
    private var networking: Networking

    public init() {
        let session = URLSession(
            configuration: URLSessionConfiguration.default
        )

        networking = Networking(
            session: session,
            builder: URLRequestBuilder()
        )
    }

    public func execute<T: Decodable>(_: T.Type, request: Request) -> AnyPublisher<T, Error> {
        networking.execute(T.self, request: request)
    }
    
    public func execute(request: Request) -> AnyPublisher<Data, Error> {
        networking.execute(request: request)
    }
}
