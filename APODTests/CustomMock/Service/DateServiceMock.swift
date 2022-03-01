//
//  DateServiceMock.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Foundation

final class DateServiceMock: DateServiceProtocol {
    func date(from date: String, format: String) -> Date? {
        Date()
    }
    
    func dateToLocalizedString(date: Date?) -> String? {
        "29 January, 2022"
    }
    
    func rangeForLast(days: Int, from date: Date) -> (startDate: String, endDate: String)? {
        ("2022-01-25", "2022-01-29")
    }
}
