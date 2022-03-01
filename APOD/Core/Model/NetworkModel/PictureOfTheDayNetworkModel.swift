//
//  PictureOfTheDayNetworkModel.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

struct PictureOfTheDayNetworkModel: Decodable {
    let copyright, date, explanation: String?
    let hdurl: String?
    let serviceVersion, title: String?
    let url, thumbnailUrl: String?
    let mediaType: MediaType?

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
        case thumbnailUrl = "thumbnail_url"
    }

    enum MediaType: String, Decodable {
        case image
        case video
    }
}
