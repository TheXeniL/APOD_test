//
//  DateServiceTests.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Foundation
import XCTest

final class DateServiceTests: XCTestCase {
    var sut: DateService?
    
    override func setUp() {
        super.setUp()
        sut = DateService(locale: Locale(identifier: "en_us"))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_date() {
        // when
        let date = sut?.date(from: "2022-01-29", format: "yyyy-MM-dd")
        
        // then
        XCTAssertNotNil(date)
        XCTAssertEqual(date, Date(timeIntervalSinceReferenceDate: 665096400))
    }
    
    func test_rangeForLast() {
        // given
        let date = Date(timeIntervalSince1970: 1643414400)
        
        // when
        let dateInterval = sut?.rangeForLast(days: 50, from: date)
        
        // then
        XCTAssertEqual(dateInterval?.startDate, "2021-12-10")
        XCTAssertEqual(dateInterval?.endDate, "2022-01-29")
    }
    
    func test_parseDateFormatToLocale() {
        // given
        let date = Date(timeIntervalSince1970: 1643414400)

        // when
        let string = sut?.dateToLocalizedString(date: date)
        
        // then
        XCTAssertEqual(string, "January 29, 2022")
    }
}
