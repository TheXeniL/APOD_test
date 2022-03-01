//
//  PictureOfTheDayListInteractorMock.swift
//  APOD
//
//  Created by Nikita Elizarov on 30.01.2022.
//

import Combine
import Foundation

final class PictureOfTheDayListInteractorMock: PictureOfTheDayListInteractorProtocol {
    func loadFavorites() -> AnyPublisher<[PictureOfTheDay], Error> {
        Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func toggleFavorite(for model: PictureOfTheDay) -> AnyPublisher<Void, Error> {
        Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetch(_ parameters: PictureOfTheDayParameters?) -> AnyPublisher<[PictureOfTheDayNetworkModel], Error> {
        getJSON()
            .eraseToAnyPublisher()
    }

    private func getJSON() -> Future<[PictureOfTheDayNetworkModel], Error> {
        Future { promise in
            guard let path = Bundle.main.path(forResource: "PictureOfTheDayNetworkModelMock", ofType: "json") else {
                return promise(.failure(MockError.failedLoadingJSONMock))
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode([PictureOfTheDayNetworkModel].self, from: data)
                return promise(.success(result))
            } catch {
                return promise(.failure(MockError.failedLoadingJSONMock))
            }
        }
    }
}
