// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import APOD
import Combine
import Foundation

class PictureOfTheDayRepositoryProtocolMock: PictureOfTheDayRepositoryProtocol {
    var favorites: [PictureOfTheDay] = []

    //MARK: - toggleFavorite

    var toggleFavoriteForCallsCount = 0
    var toggleFavoriteForCalled: Bool {
        return toggleFavoriteForCallsCount > 0
    }
    var toggleFavoriteForReceivedModel: PictureOfTheDay?
    var toggleFavoriteForReceivedInvocations: [PictureOfTheDay] = []
    var toggleFavoriteForReturnValue: Future<Void, Error>!
    var toggleFavoriteForClosure: ((PictureOfTheDay) -> Future<Void, Error>)?

    func toggleFavorite(for model: PictureOfTheDay) -> Future<Void, Error> {
        toggleFavoriteForCallsCount += 1
        toggleFavoriteForReceivedModel = model
        toggleFavoriteForReceivedInvocations.append(model)
        return toggleFavoriteForClosure.map({ $0(model) }) ?? toggleFavoriteForReturnValue
    }

    //MARK: - add

    var addCallsCount = 0
    var addCalled: Bool {
        return addCallsCount > 0
    }
    var addReceivedModel: PictureOfTheDay?
    var addReceivedInvocations: [PictureOfTheDay] = []
    var addReturnValue: Future<Void, Error>!
    var addClosure: ((PictureOfTheDay) -> Future<Void, Error>)?

    func add(_ model: PictureOfTheDay) -> Future<Void, Error> {
        addCallsCount += 1
        addReceivedModel = model
        addReceivedInvocations.append(model)
        return addClosure.map({ $0(model) }) ?? addReturnValue
    }

    //MARK: - remove

    var removeCallsCount = 0
    var removeCalled: Bool {
        return removeCallsCount > 0
    }
    var removeReceivedId: String?
    var removeReceivedInvocations: [String] = []
    var removeReturnValue: Future<Void, Error>!
    var removeClosure: ((String) -> Future<Void, Error>)?

    func remove(_ id: String) -> Future<Void, Error> {
        removeCallsCount += 1
        removeReceivedId = id
        removeReceivedInvocations.append(id)
        return removeClosure.map({ $0(id) }) ?? removeReturnValue
    }

}
