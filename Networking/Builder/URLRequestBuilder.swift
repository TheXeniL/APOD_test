//
//  URLRequestBuilder.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

struct URLRequestBuilder: URLRequestBuilderProtocol {
    func makeURLRequest(from request: Request) throws -> URLRequest {
        var urlComponents = URLComponents(string: request.path)
        
        urlComponents?.queryItems = request.query?.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        guard let url = URL(string: urlComponents?.string ?? "") else {
            throw RequestError.parameterEncodingFailed(reason: .missingURL)
        }

        var urlRequest = URLRequest(url: url)
        
        if request.body != nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpMethod = request.method.rawValue
        request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        urlRequest.httpBody = request.body?.toJSONData()
        
        return urlRequest
    }
}

extension Encodable {
    public func toJSONData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
