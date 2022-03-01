//
//  PictureOfTheDayListInteractorMock.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Combine
import Foundation

final class PictureOfTheDayListInteractorMock: PictureOfTheDayListInteractorProtocol {
    var shouldFail = false

    func loadFavorites() -> AnyPublisher<[PictureOfTheDay], Error> {
        guard !shouldFail else {
            return Fail(error: ErrorMock.failureResponse)
                .eraseToAnyPublisher()
        }

        return Just(
            [
                PictureOfTheDay(
                    id: "0",
                    title: "Test",
                    description: "Test",
                    date: "01-08-2022",
                    author: "Me",
                    type: .image(url: URL(fileURLWithPath: ""))
                ),
            ]
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }

    func toggleFavorite(for model: PictureOfTheDay) -> AnyPublisher<Void, Error> {
        guard !shouldFail else {
            return Fail(error: ErrorMock.failureResponse)
                .eraseToAnyPublisher()
        }

        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetch(_ parameters: PictureOfTheDayParameters?) -> AnyPublisher<[PictureOfTheDayNetworkModel], Error> {
        guard !shouldFail else {
            return Fail(error: ErrorMock.failureResponse)
                .eraseToAnyPublisher()
        }

        return Just([
            .init(
                copyright: "Test",
                date: "2022-01-29",
                explanation: "Description",
                hdurl: nil,
                serviceVersion: nil,
                title: "Title",
                url: "url",
                thumbnailUrl: "thumbnailURL",
                mediaType: .image
            ),
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
