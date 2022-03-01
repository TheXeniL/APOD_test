//
//  PictureOfTheDay.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

struct PictureOfTheDay: Identifiable {
    enum MediaType {
        case image(url: URL?)
        case video(url: URL?, thumbnail: URL?)
    }

    let id: String
    let title: String
    let description: String?
    let date: String?
    let author: String?
    let type: MediaType?

    var image: URL? {
        switch self.type {
        case let .image(url):
            return url
        case let .video(_, thumbnail):
            return thumbnail
        default:
            return nil
        }
    }

    var videoURL: URL? {
        guard let type = type, case let MediaType.video(url, _) = type else {
            return nil
        }

        return url
    }

    init(
        id: String = UUID().uuidString,
        title: String,
        description: String? = nil,
        date: String? = nil,
        author: String? = nil,
        type: MediaType? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.author = author
        self.type = type
    }
}

// MARK: Convenience init

extension PictureOfTheDay {
    init(_ storageModel: PictureOfTheDayDB) {
        var type: MediaType?
        let contentURL = URL(string: storageModel.contentURL)
        let thumbnailURL = URL(string: storageModel.thumbnailURL)

        switch storageModel.mediaType {
        case "image":
            type = .image(url: contentURL)
        case "video":
            type = .video(url: contentURL, thumbnail: thumbnailURL)
        default:
            break
        }

        self.init(
            id: storageModel.id,
            title: storageModel.title,
            description: storageModel.subtitle,
            date: storageModel.date,
            author: storageModel.author,
            type: type
        )
    }
}
