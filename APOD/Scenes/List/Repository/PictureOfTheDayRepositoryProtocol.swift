//
//  PictureOfTheDayRepositoryProtocol.swift
//  APOD
//
//  Created by Nikita Elizarov on 03.02.2022.
//

import Foundation
import Combine

//sourcery: AutoMockable
protocol PictureOfTheDayRepositoryProtocol {
    var favorites: [PictureOfTheDay] { get }
    
    func toggleFavorite(for model: PictureOfTheDay) -> Future<Void, Error>
    func add(_ model: PictureOfTheDay) -> Future<Void, Error>
    func remove(_ id: String) -> Future<Void, Error>
}
