//
//  DateServiceProtocol.swift
//  APOD
//
//  Created by Nikita Elizarov on 29.01.2022.
//

import Foundation

//sourcery: AutoMockable
protocol DateServiceProtocol {
    func date(from date: String, format: String) -> Date?
    func rangeForLast(days: Int, from date: Date) -> (startDate: String, endDate: String)?
    func dateToLocalizedString(date: Date?) -> String?
}
