//
//  PictureOfTheDayListInteractor.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation
import Networking
import Combine

final class PictureOfTheDayListInteractor: PictureOfTheDayListInteractorProtocol {
    private weak var networkClient: NetworkingProtocol?
    private let repository: PictureOfTheDayRepositoryProtocol
    
    init(
        networkClient: NetworkingProtocol?,
        repository: PictureOfTheDayRepositoryProtocol
    ) {
        self.networkClient = networkClient
        self.repository = repository
    }
    
    func fetch(_ parameters: PictureOfTheDayParameters?) -> AnyPublisher<[PictureOfTheDayNetworkModel], Error> {
        guard let networkClient = networkClient else {
            return Fail(error: NetworkingError.failedIntializingNetworkClient)
                .eraseToAnyPublisher()
        }
                
        let request = APODAPI.fetchPictureOfTheDay(parameters).makeRegularRequest()
        
        /// The API may return single model which results in different parsing
        switch parameters?.filter {
        case .count, .range:
            return networkClient.execute([PictureOfTheDayNetworkModel].self, request: request)
        case .date, .none:
            return networkClient.execute(PictureOfTheDayNetworkModel.self, request: request)
                .map { model in [model] }
                .eraseToAnyPublisher()
        }
    }
    
    // MARK: - Local storage
    
    func loadFavorites() -> AnyPublisher<[PictureOfTheDay], Error> {
        Just(repository.favorites)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func toggleFavorite(for model: PictureOfTheDay) -> AnyPublisher<Void, Error> {
        repository
            .toggleFavorite(for: model)
            .eraseToAnyPublisher()
    }
}
