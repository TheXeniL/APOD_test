//
//  PictureOfTheDayDetailsViewModelTests.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Foundation
import XCTest

final class PictureOfTheDayDetailsViewModelTests: XCTestCase {
    typealias State = PictureOfTheDayDetailsViewModel.State
    typealias Event = PictureOfTheDayDetailsViewModel.Event

    var sut: PictureOfTheDayDetailsViewModel?
    var invokedDismiss: Bool = false
    var invokedToggleFavorite: Bool = false
    
    override func setUp() {
        super.setUp()
        sut = PictureOfTheDayDetailsViewModel(
            dependency: .init(
                pictureOfTheDay: .init(id: "0",title: "Test"),
                onDismiss: { [weak self] in
                    self?.invokedDismiss = true
                },
                onToggleFavorite: { [weak self] _ in
                    self?.invokedToggleFavorite = true
                }
            )
        )
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        invokedDismiss = false
    }
    
    func test_title() {
        XCTAssertEqual(sut?.title, "Test")
    }
    
    func test_onAppearEvent_reduces_loaded_state() {
        // given
        var initialDetails: PictureOfTheDay?

        // when
        sut?.handleEvent(.onAppear)
        
        if let state = sut?.state, case let State.loaded(details) = state {
            initialDetails = details
        }
        
        // then
        XCTAssertNotNil(initialDetails)
        XCTAssertNotNil(initialDetails?.id, "0")
    }
    
    func test_onDismiss_reduces_sideEffect() {
        // when
        sut?.handleEvent(.onDismiss)
        
        // then
        XCTAssertTrue(invokedDismiss)
    }
    
    func test_onFavorite_reduces_sideEffect() {
        // when
        sut?.handleEvent(.onFavorite)
        
        // then
        XCTAssertTrue(invokedToggleFavorite)
    }
}
