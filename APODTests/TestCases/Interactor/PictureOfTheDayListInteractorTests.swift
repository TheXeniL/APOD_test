//
//  PictureOfTheDayListInteractorTests.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Combine
import CombineSchedulers
import Foundation
import Networking
import XCTest

final class PictureOfTheDayListInteractorTests: XCTestCase {
    var sut: PictureOfTheDayListInteractor?
    var networkClientMock: NetworkingMock!
    var repository: PictureOfTheDayRepositoryProtocolMock!
    
    var disposeBag = Set<AnyCancellable>()
    var scheduler: AnySchedulerOf<DispatchQueue> = .immediate
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        networkClientMock = nil
        super.tearDown()
    }
    
    func test_fetch_without_filter() {
        // given
        repository = PictureOfTheDayRepositoryProtocolMock()
        networkClientMock = NetworkingMock(response:
            PictureOfTheDayNetworkModel(
                copyright: "Test",
                date: "2022-01-29",
                explanation: "Description",
                hdurl: nil,
                serviceVersion: nil,
                title: "Title",
                url: "url",
                thumbnailUrl: "thumbnailURL",
                mediaType: .image
            )
        )

        sut = PictureOfTheDayListInteractor(
            networkClient: networkClientMock,
            repository: repository
        )
                
        // when
        sut?
            .fetch(nil)
            .receive(on: scheduler)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] value in
                    // then
                    XCTAssertEqual(value.count, 1)
                    XCTAssertEqual(self?.networkClientMock.invokedExecute, true)
                }
            )
            .store(in: &disposeBag)
    }
    
    func test_fetch_with_filter() {
        // given
        repository = PictureOfTheDayRepositoryProtocolMock()
        networkClientMock = NetworkingMock(response:
            [
                PictureOfTheDayNetworkModel(
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
                PictureOfTheDayNetworkModel(
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
            ]
        )

        sut = PictureOfTheDayListInteractor(
            networkClient: networkClientMock,
            repository: repository
        )

        // when
        sut?
            .fetch(.init(filter: .range(startDate: "", endDate: "")))
            .receive(on: scheduler)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] value in
                    // then
                    XCTAssertEqual(value.count, 2)
                    XCTAssertEqual(self?.networkClientMock.invokedExecute, true)
                }
            )
            .store(in: &disposeBag)
    }
    
    func test_loadFavorites() {
        // given
        repository = PictureOfTheDayRepositoryProtocolMock()
        networkClientMock = NetworkingMock(response: "")
        repository.favorites = [PictureOfTheDay(title: "Test")]

        sut = PictureOfTheDayListInteractor(
            networkClient: networkClientMock,
            repository: repository
        )
        
        // when
        sut?
            .loadFavorites()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { value in
                    // then
                    XCTAssertEqual(value.count, 1)
                    XCTAssertEqual(value.contains(where: { $0.title == "Test" }), true)
                }
            )
            .store(in: &disposeBag)
    }
    
    func test_toggleFavorite() {
        // given
        repository = PictureOfTheDayRepositoryProtocolMock()
        networkClientMock = NetworkingMock(response: "")
        repository.toggleFavoriteForReturnValue = Future { promise in
            promise(.success(()))
        }

        sut = PictureOfTheDayListInteractor(
            networkClient: networkClientMock,
            repository: repository
        )
        
        // when
        sut?
            .toggleFavorite(for: .init(title: "Test"))
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] _ in
                    // then
                    XCTAssertEqual(self?.repository.toggleFavoriteForCalled, true)
                    XCTAssertEqual(self?.repository.toggleFavoriteForCallsCount, 1)
                }
            )
            .store(in: &disposeBag)
    }
}
