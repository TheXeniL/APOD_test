//
//  NetworkingMock.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

import Combine
import Foundation
import Networking

final class NetworkingMock: NetworkingProtocol {
    private let response: Any
    var invokedExecute: Bool = false

    init(response: Any) {
        self.response = response
    }

    func execute<T>(_: T.Type, request: Request) -> AnyPublisher<T, Error> where T: Decodable {
        guard let response = response as? T else {
            return Fail(error: ErrorMock.failureResponse)
                .eraseToAnyPublisher()
        }

        invokedExecute = true

        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func execute(request: Request) -> AnyPublisher<Data, Error> {
        defer { invokedExecute = true }
        return Just(Data())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
