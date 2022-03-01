// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import APOD
import Combine
import Foundation

class PictureOfTheDayListInteractorProtocolMock: PictureOfTheDayListInteractorProtocol {

    //MARK: - fetch

    var fetchCallsCount = 0
    var fetchCalled: Bool {
        return fetchCallsCount > 0
    }
    var fetchReceivedParameters: PictureOfTheDayParameters?
    var fetchReceivedInvocations: [PictureOfTheDayParameters?] = []
    var fetchReturnValue: AnyPublisher<[PictureOfTheDayNetworkModel], Error>!
    var fetchClosure: ((PictureOfTheDayParameters?) -> AnyPublisher<[PictureOfTheDayNetworkModel], Error>)?

    func fetch(_ parameters: PictureOfTheDayParameters?) -> AnyPublisher<[PictureOfTheDayNetworkModel], Error> {
        fetchCallsCount += 1
        fetchReceivedParameters = parameters
        fetchReceivedInvocations.append(parameters)
        return fetchClosure.map({ $0(parameters) }) ?? fetchReturnValue
    }

    //MARK: - loadFavorites

    var loadFavoritesCallsCount = 0
    var loadFavoritesCalled: Bool {
        return loadFavoritesCallsCount > 0
    }
    var loadFavoritesReturnValue: AnyPublisher<[PictureOfTheDay], Error>!
    var loadFavoritesClosure: (() -> AnyPublisher<[PictureOfTheDay], Error>)?

    func loadFavorites() -> AnyPublisher<[PictureOfTheDay], Error> {
        loadFavoritesCallsCount += 1
        return loadFavoritesClosure.map({ $0() }) ?? loadFavoritesReturnValue
    }

    //MARK: - toggleFavorite

    var toggleFavoriteForCallsCount = 0
    var toggleFavoriteForCalled: Bool {
        return toggleFavoriteForCallsCount > 0
    }
    var toggleFavoriteForReceivedModel: PictureOfTheDay?
    var toggleFavoriteForReceivedInvocations: [PictureOfTheDay] = []
    var toggleFavoriteForReturnValue: AnyPublisher<Void, Error>!
    var toggleFavoriteForClosure: ((PictureOfTheDay) -> AnyPublisher<Void, Error>)?

    func toggleFavorite(for model: PictureOfTheDay) -> AnyPublisher<Void, Error> {
        toggleFavoriteForCallsCount += 1
        toggleFavoriteForReceivedModel = model
        toggleFavoriteForReceivedInvocations.append(model)
        return toggleFavoriteForClosure.map({ $0(model) }) ?? toggleFavoriteForReturnValue
    }

}
