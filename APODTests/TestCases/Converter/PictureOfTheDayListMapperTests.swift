//
//  PictureOfTheDayListMapperTests.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Foundation
import XCTest

final class PictureOfTheDayListMapperTests: XCTestCase {
    var sut: PictureOfTheDayListMapper?
    var dateSerivce: DateServiceProtocolMock!
    
    override func setUp() {
        super.setUp()
        dateSerivce = DateServiceProtocolMock()
        dateSerivce.dateFromFormatReturnValue = Date()
        dateSerivce.dateToLocalizedStringDateReturnValue = "29 January, 2022"
        dateSerivce.rangeForLastDaysFromReturnValue = ("2022-01-25", "2022-01-29")

        sut = PictureOfTheDayListMapper(
            dateService: dateSerivce
        )
    }

    override func tearDown() {
        sut = nil
        dateSerivce = nil
        super.tearDown()
    }
    
    func test_map_networkModel() {
        // given
        let networkModel = [
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
                copyright: "Test1",
                date: "2022-01-28",
                explanation: "Description1",
                hdurl: nil,
                serviceVersion: nil,
                title: "Title1",
                url: "url1",
                thumbnailUrl: "thumbnailURL1",
                mediaType: .video
            ),
        ]
        
        // when
        let model = sut?.map(networkModel)
        
        XCTAssertEqual(model?.count, 2)
        XCTAssertEqual(model?.contains(where: { $0.title == "Title" }), true)
        XCTAssertEqual(model?.first(where: { $0.title == "Title1" })?.date, "29 January, 2022")
        XCTAssertEqual(dateSerivce.dateFromFormatCalled, true)
        XCTAssertEqual(dateSerivce.dateFromFormatCallsCount, 2)
    }
    
    func test_lastDays() {
        // when
        let dates = sut?.map(lastDays: 50)
        
        // then
        XCTAssertEqual(dates?.startDate, "2022-01-25")
        XCTAssertEqual(dates?.endDate, "2022-01-29")
        XCTAssertEqual(dateSerivce.rangeForLastDaysFromCalled, true)
        XCTAssertEqual(dateSerivce.rangeForLastDaysFromCallsCount, 1)
    }
}
    
