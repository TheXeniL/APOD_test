// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import APOD
import Combine
import Foundation

class PictureOfTheDayListMapperProtocolMock: PictureOfTheDayListMapperProtocol {

    //MARK: - map

    var mapCallsCount = 0
    var mapCalled: Bool {
        return mapCallsCount > 0
    }
    var mapReceivedModel: [PictureOfTheDayNetworkModel]?
    var mapReceivedInvocations: [[PictureOfTheDayNetworkModel]] = []
    var mapReturnValue: [PictureOfTheDay]!
    var mapClosure: (([PictureOfTheDayNetworkModel]) -> [PictureOfTheDay])?

    func map(_ model: [PictureOfTheDayNetworkModel]) -> [PictureOfTheDay] {
        mapCallsCount += 1
        mapReceivedModel = model
        mapReceivedInvocations.append(model)
        return mapClosure.map({ $0(model) }) ?? mapReturnValue
    }

    //MARK: - map

    var mapLastDaysCallsCount = 0
    var mapLastDaysCalled: Bool {
        return mapLastDaysCallsCount > 0
    }
    var mapLastDaysReceivedLastDays: Int?
    var mapLastDaysReceivedInvocations: [Int] = []
    var mapLastDaysReturnValue: (startDate: String, endDate: String)?
    var mapLastDaysClosure: ((Int) -> (startDate: String, endDate: String)?)?

    func map(lastDays: Int) -> (startDate: String, endDate: String)? {
        mapLastDaysCallsCount += 1
        mapLastDaysReceivedLastDays = lastDays
        mapLastDaysReceivedInvocations.append(lastDays)
        return mapLastDaysClosure.map({ $0(lastDays) }) ?? mapLastDaysReturnValue
    }

}
