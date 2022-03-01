//
//  PictureOfTheDayListMapperMock.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Foundation

final class PictureOfTheDayListMapperMock: PictureOfTheDayListMapperProtocol {
    func map(_ model: [PictureOfTheDayNetworkModel]) -> [PictureOfTheDay] {
        [
            .init(
                id: "0",
                title: "Title1",
                description: "Description",
                date: "2022-01-29",
                author: "Author",
                type: .image(url: URL(string: "test"))
            ),
            .init(
                id: "1",
                title: "Title2",
                description: "Description",
                date: "2022-01-28",
                author: nil,
                type: .video(url: URL(string: "test"), thumbnail: URL(string: "test"))
            ),
        ]
    }

    func map(lastDays: Int) -> (startDate: String, endDate: String)? {
        ("2022-01-25", "2022-01-29")
    }
}
