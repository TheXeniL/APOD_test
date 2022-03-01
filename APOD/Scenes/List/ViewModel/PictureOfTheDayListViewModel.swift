//
//  PictureOfTheDayListViewModel.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Combine
import CombineSchedulers
import Foundation
import SwiftUI

final class PictureOfTheDayListViewModel: ObservableObject {
    private enum Constant {
        static let lastPicturesForDays = 5
    }

    enum ListType {
        case list
        case favorites
    }

    @Published private(set) var state: State = .idle
    @Published var pictureOfTheDayDetails: PictureOfTheDay?

    private let dependency: Dependency
    private var disposeBag = Set<AnyCancellable>()

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func onAppear() { handleEvent(.onAppear) }

    func handleEvent(_ event: Event) {
        reduce(&state, event)
    }

    private func reduce(_ state: inout State, _ event: PictureOfTheDayListViewModel.Event) {
        switch event {
        case .onAppear:
            state = .loading
            switch dependency.type {
            case .list:
                fetchPicturesOfTheDay()
            case .favorites:
                loadFavorites()
            }
        case .onRetry:
            state = .loading
            handleEvent(.onAppear)
        case let .onFailedToLoad(error):
            state = .error(error)
        case let .onLoadedPictures(value):
            state = .loaded(value)
        case let .onPresentDetails(value):
            presentDetails(with: value)
        case .onDismissDetails:
            dismissDetails()
        case let .onToggleFavorite(value):
            toggleFavorite(for: value)
        }
    }
}

// MARK: - Depencdency

extension PictureOfTheDayListViewModel {
    struct Dependency {
        let type: ListType
        let mapper: PictureOfTheDayListMapperProtocol
        let interactor: PictureOfTheDayListInteractorProtocol?
        let scheduler: AnySchedulerOf<DispatchQueue>
    }
}

// MARK: - State

extension PictureOfTheDayListViewModel {
    enum State {
        case idle
        case loading
        case loaded([PictureOfTheDay])
        case error(Error)
    }
}

// MARK: - Event

extension PictureOfTheDayListViewModel {
    enum Event {
        case onAppear
        case onRetry
        case onFailedToLoad(Error)
        case onLoadedPictures([PictureOfTheDay])
        case onPresentDetails(PictureOfTheDay)
        case onDismissDetails
        case onToggleFavorite(PictureOfTheDay)
    }
}

// MARK: - Side effects

extension PictureOfTheDayListViewModel {
    func presentDetails(with details: PictureOfTheDay) {
        pictureOfTheDayDetails = details
    }

    func dismissDetails() {
        pictureOfTheDayDetails = nil
    }

    func fetchPicturesOfTheDay() {
        var parameters: PictureOfTheDayParameters?

        if let range = dependency.mapper.map(lastDays: Constant.lastPicturesForDays) {
            parameters = .init(
                filter: .range(startDate: range.startDate, endDate: range.endDate)
            )
        }

        dependency
            .interactor?
            .fetch(parameters)
            .receive(on: dependency.scheduler)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.handleEvent(.onFailedToLoad(error))
                }
            } receiveValue: { [weak self] model in
                self?.handleEvent(
                    .onLoadedPictures(self?.dependency.mapper.map(model).reversed() ?? [])
                )
            }
            .store(in: &disposeBag)
    }

    func toggleFavorite(for model: PictureOfTheDay) {
        dependency
            .interactor?
            .toggleFavorite(for: model)
            .subscribe(on: DispatchQueue.global())
            .receive(on: dependency.scheduler)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] _ in
                    self?.loadFavorites()
                }
            )
            .store(in: &disposeBag)
    }

    func loadFavorites() {
        dependency
            .interactor?
            .loadFavorites()
            .subscribe(on: DispatchQueue.global())
            .receive(on: dependency.scheduler)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.handleEvent(.onFailedToLoad(error))
                }
            } receiveValue: { [weak self] data in
                self?.handleEvent(.onLoadedPictures(data))
            }
            .store(in: &disposeBag)
    }
}
