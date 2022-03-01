//
//  PictureOfTheDayDetailsViewModel.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

final class PictureOfTheDayDetailsViewModel: ObservableObject, Identifiable {
    @Published private(set) var state: State = .idle

    private let dependency: Dependency

    var title: String {
        dependency.pictureOfTheDay.title
    }

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func handleEvent(_ event: Event) {
        reduce(&state, event)
    }
    
    private func reduce(_ state: inout State, _ event: PictureOfTheDayDetailsViewModel.Event) {
        switch event {
        case .onAppear:
            state = .loaded(dependency.pictureOfTheDay)
        case .onDismiss:
            dependency.onDismiss()
        case .onFavorite:
            dependency.onToggleFavorite(dependency.pictureOfTheDay)
        }
    }
}


// MARK: - Depencdency

extension PictureOfTheDayDetailsViewModel {
    struct Dependency {
        let pictureOfTheDay: PictureOfTheDay
        let onDismiss: () -> Void
        let onToggleFavorite: (PictureOfTheDay) -> Void
    }
}

// MARK: - State

extension PictureOfTheDayDetailsViewModel {
    enum State {
        case idle
        case loaded(PictureOfTheDay)
    }
}

// MARK: - Event

extension PictureOfTheDayDetailsViewModel {
    enum Event {
        case onAppear
        case onDismiss
        case onFavorite
    }
}
