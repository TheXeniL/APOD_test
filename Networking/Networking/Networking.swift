//
//  Networking.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Combine
import Foundation

struct Networking {
    private let session: URLSession
    private let builder: URLRequestBuilderProtocol

    init(
        session: URLSession,
        builder: URLRequestBuilderProtocol
    ) {
        self.session = session
        self.builder = builder
    }
    
    func execute<T: Decodable>(_: T.Type, request: Request) -> AnyPublisher<T, Error> {
        do {
            let urlRequest = try builder.makeURLRequest(from: request)
            return execute(T.self, urlRequest: urlRequest)
        } catch {
            return onCatch(T.self, error)
        }
    }
    
    func execute(request: Request) -> AnyPublisher<Data, Error> {
        do {
            print(request)
            let urlRequest = try builder.makeURLRequest(from: request)
            return execute(urlRequest: urlRequest)
                .map { $0.0 }
                .eraseToAnyPublisher()
        } catch {
            return onCatch(Data.self, error)
        }
    }
    
    private func execute<T: Decodable>(
        _: T.Type,
        urlRequest: URLRequest
    ) -> AnyPublisher<T, Error> {
        let parser = JSONParser()
        print(urlRequest)

        return execute(urlRequest: urlRequest)
            .tryMap { data, _ in
                try parser.parse(T.self, data: data)
            }
            .eraseToAnyPublisher()
    }
    
    private func execute(
        urlRequest: URLRequest
    ) -> AnyPublisher<(Data, URLResponse), Error> {
        session
            .dataTaskPublisher(for: urlRequest)
            .mapError(RequestError.sessionTaskFailed)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse,
                   !(200 ..< 300).contains(response.statusCode)
                {
                    throw RequestError.responseValidationFailed(
                        reason: .unacceptableStatusCode(
                            code: response.statusCode,
                            headers: response.allHeaderFields,
                            body: data
                        )
                    )
                }

                return (data, response)
            }
            .eraseToAnyPublisher()
    }
    
    private func onCatch<T>(_: T.Type, _ error: Error) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            print(error.localizedDescription)
            promise(.failure(error))
        }
        .eraseToAnyPublisher()
    }
}
