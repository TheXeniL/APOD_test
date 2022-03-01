// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import APOD
import Combine
import Foundation

class DateServiceProtocolMock: DateServiceProtocol {

    //MARK: - date

    var dateFromFormatCallsCount = 0
    var dateFromFormatCalled: Bool {
        return dateFromFormatCallsCount > 0
    }
    var dateFromFormatReceivedArguments: (date: String, format: String)?
    var dateFromFormatReceivedInvocations: [(date: String, format: String)] = []
    var dateFromFormatReturnValue: Date?
    var dateFromFormatClosure: ((String, String) -> Date?)?

    func date(from date: String, format: String) -> Date? {
        dateFromFormatCallsCount += 1
        dateFromFormatReceivedArguments = (date: date, format: format)
        dateFromFormatReceivedInvocations.append((date: date, format: format))
        return dateFromFormatClosure.map({ $0(date, format) }) ?? dateFromFormatReturnValue
    }

    //MARK: - rangeForLast

    var rangeForLastDaysFromCallsCount = 0
    var rangeForLastDaysFromCalled: Bool {
        return rangeForLastDaysFromCallsCount > 0
    }
    var rangeForLastDaysFromReceivedArguments: (days: Int, date: Date)?
    var rangeForLastDaysFromReceivedInvocations: [(days: Int, date: Date)] = []
    var rangeForLastDaysFromReturnValue: (startDate: String, endDate: String)?
    var rangeForLastDaysFromClosure: ((Int, Date) -> (startDate: String, endDate: String)?)?

    func rangeForLast(days: Int, from date: Date) -> (startDate: String, endDate: String)? {
        rangeForLastDaysFromCallsCount += 1
        rangeForLastDaysFromReceivedArguments = (days: days, date: date)
        rangeForLastDaysFromReceivedInvocations.append((days: days, date: date))
        return rangeForLastDaysFromClosure.map({ $0(days, date) }) ?? rangeForLastDaysFromReturnValue
    }

    //MARK: - dateToLocalizedString

    var dateToLocalizedStringDateCallsCount = 0
    var dateToLocalizedStringDateCalled: Bool {
        return dateToLocalizedStringDateCallsCount > 0
    }
    var dateToLocalizedStringDateReceivedDate: Date?
    var dateToLocalizedStringDateReceivedInvocations: [Date?] = []
    var dateToLocalizedStringDateReturnValue: String?
    var dateToLocalizedStringDateClosure: ((Date?) -> String?)?

    func dateToLocalizedString(date: Date?) -> String? {
        dateToLocalizedStringDateCallsCount += 1
        dateToLocalizedStringDateReceivedDate = date
        dateToLocalizedStringDateReceivedInvocations.append(date)
        return dateToLocalizedStringDateClosure.map({ $0(date) }) ?? dateToLocalizedStringDateReturnValue
    }

}
