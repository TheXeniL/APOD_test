//
//  PictureOfTheDayListViewModelTests.swift
//  APODTests
//
//  Created by Nikita Elizarov on 3/1/22.
//

@testable import APOD
import Foundation
import XCTest

final class PictureOfTheDayListViewModelTests: XCTestCase {
    typealias State = PictureOfTheDayListViewModel.State
    typealias Event = PictureOfTheDayListViewModel.Event

    var sut: PictureOfTheDayListViewModel?
    private var interactor: PictureOfTheDayListInteractorMock?
    
    override func setUp() {
        super.setUp()
        interactor = PictureOfTheDayListInteractorMock()
        sut = PictureOfTheDayListViewModel(
            dependency: .init(
                type: .list,
                mapper: PictureOfTheDayListMapperMock(),
                interactor: interactor,
                scheduler: .immediate
            )
        )
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        interactor = nil
    }
    
    func test_onAppearEvent_reduces_loading_state() {
        // given
        var loadingState = false

        // when
        sut?.handleEvent(.onAppear)
        
        if let state = sut?.state, case State.loading = state {
            loadingState = true
        }
        
        // then
        XCTAssertTrue(loadingState)
    }
    
    func test_onLoadedPictures_reduces_loaded_state() {
        // given
        var loadedState = false
        var initialData: [PictureOfTheDay] = []
        
        // when
        sut?.handleEvent(
            .onLoadedPictures([.init(title: "Test1"), .init(title: "Test2")])
        )
        
        if let state = sut?.state, case let State.loaded(data) = state {
            loadedState = true
            initialData = data
        }
        
        // then
        XCTAssertTrue(loadedState)
        XCTAssertEqual(initialData.count, 2)
    }
    
    func test_onFailedToLoad_reduces_error_state() {
        // given
        var errorState = false
        
        // when
        sut?.handleEvent(
            .onFailedToLoad(ErrorMock.failureResponse)
        )
        
        if let state = sut?.state, case State.error = state {
            errorState = true
        }
        
        // then
        XCTAssertTrue(errorState)
    }
    
    func test_onRetry_reduces_loading_state() {
        // given
        var loadingState = false

        // when
        sut?.handleEvent(.onRetry)
        
        if let state = sut?.state, case State.loading = state {
            loadingState = true
        }
        
        // then
        XCTAssertTrue(loadingState)
    }
    
    func test_onPictureSelected_reduces_sideEffect_detailsPresentation() {
        // given
        sut?.pictureOfTheDayDetails = nil
        
        // when
        sut?.handleEvent(.onPresentDetails(.init(id: "0", title: "Title")))
        
        // then
        XCTAssertNotNil(sut?.pictureOfTheDayDetails)
        XCTAssertEqual(sut?.pictureOfTheDayDetails?.id, "0")
    }
    
    func test_fetchPicturesOfTheDay_sideEffect() {
        // given
        var initialData: [PictureOfTheDay] = []

        // when
        sut?.fetchPicturesOfTheDay()
        
        if let state = sut?.state, case let State.loaded(data) = state {
            initialData = data
        }
        
        // then
        XCTAssertEqual(initialData.count, 2)
    }
    
    func test_fetchPicturesOfTheDay_sideEffect_shouldFail() {
        // given
        var errorState = false
        interactor?.shouldFail = true

        // when
        sut?.fetchPicturesOfTheDay()
        
        if let state = sut?.state, case State.error = state {
            errorState = true
        }
        
        // then
        XCTAssertTrue(errorState)
    }
    
    func test_presentDetails_sideEffect() {
        // given
        sut?.pictureOfTheDayDetails = nil
        
        // when
        sut?.presentDetails(with: .init(id: "0", title: "Test"))
        
        // then
        XCTAssertEqual(sut?.pictureOfTheDayDetails?.id, "0")
        XCTAssertEqual(sut?.pictureOfTheDayDetails?.title, "Test")
    }
    
    func test_onDismissDetails_reduces_sideEffect() {
        // given
        sut?.pictureOfTheDayDetails = .init(title: "Test")
        
        // when
        sut?.handleEvent(.onDismissDetails)
        
        // then
        XCTAssertNil(sut?.pictureOfTheDayDetails)
    }
}
