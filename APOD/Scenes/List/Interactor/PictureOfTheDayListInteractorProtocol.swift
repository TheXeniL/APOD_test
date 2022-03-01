//
//  PictureOfTheDayListInteractorProtocol.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Combine
import Foundation

//sourcery: AutoMockable
protocol PictureOfTheDayListInteractorProtocol {
    // Networking
    func fetch(_ parameters: PictureOfTheDayParameters?) -> AnyPublisher<[PictureOfTheDayNetworkModel], Error>

    // Local storage
    func loadFavorites() -> AnyPublisher<[PictureOfTheDay], Error>
    func toggleFavorite(for model: PictureOfTheDay) -> AnyPublisher<Void, Error>
}
