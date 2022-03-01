//
//  DateService.swift
//  APOD
//
//  Created by Nikita Elizarov on 29.01.2022.
//

import Foundation

// Date formates
public extension Date {
    static let networkDate = "yyyy-MM-dd"
    static let uiDate = "dd MMMM yyyy"
}

final class DateService: DateServiceProtocol {
    /// Too expensive to recreate DateFormatter https://sarunw.com/posts/how-expensive-is-dateformatter/
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        return dateFormatter
    }()

    var calendar: Calendar {
        Calendar.current
    }

    private let locale: Locale

    init(locale: Locale) {
        self.locale = locale
    }

    func date(from date: String, format: String) -> Date? {
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }

    func rangeForLast(days: Int, from date: Date) -> (startDate: String, endDate: String)? {
        guard let dateForLast = calendar.date(byAdding: .day, value: -days, to: date) else {
            return nil
        }

        dateFormatter.dateFormat = Date.networkDate

        return (
            startDate: dateFormatter.string(from: dateForLast),
            endDate: dateFormatter.string(from: date)
        )
    }

    func dateToLocalizedString(date: Date?) -> String? {
        guard let date = date else {
            return nil
        }

        /// As there is no locale provided for the date we're going to use the devices locale
        dateFormatter.setLocalizedDateFormatFromTemplate(Date.uiDate)
        return dateFormatter.string(from: date)
    }
}
