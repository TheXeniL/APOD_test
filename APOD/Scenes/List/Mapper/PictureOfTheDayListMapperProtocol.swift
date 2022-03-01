//
//  PictureOfTheDayListMapperProtocol.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

//sourcery: AutoMockable
protocol PictureOfTheDayListMapperProtocol {
    func map(_ model: [PictureOfTheDayNetworkModel]) -> [PictureOfTheDay]
    func map(lastDays: Int) -> (startDate: String, endDate: String)?
}
