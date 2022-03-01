//
//  APOD+API.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation
import Networking

extension APODAPI: APICall {
    var baseURL: String {
        "https://api.nasa.gov"
    }

    private var apiKey: String? {
        ConfigManager().retrieveNASAApiKey()
    }

    var path: String {
        switch self {
        case .fetchPictureOfTheDay:
            return baseURL + "/planetary/apod"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchPictureOfTheDay:
            return .get
        }
    }
    
    var queryParameters: [String: String]? {
        var parameters: [String: String] = [:]
        
        if let apiKey = apiKey {
            parameters["api_key"] = apiKey
        }

        switch self {
        case let .fetchPictureOfTheDay(model):
            parameters["thumbs"] = "true"
            
            if let filter = model?.filter {
                switch filter {
                case let .count(value):
                    parameters["count"] = value
                case let .date(value):
                    parameters["date"] = value
                case let .range(startDate, endDate):
                    parameters["start_date"] = startDate
                    parameters["end_date"] = endDate
                }
            }
        }

        return parameters
    }
    
    var body: Encodable? {
        switch self {
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
