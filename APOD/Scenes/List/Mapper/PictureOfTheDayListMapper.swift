//
//  PictureOfTheDayListMapper.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

final class PictureOfTheDayListMapper: PictureOfTheDayListMapperProtocol {
    private let dateService: DateServiceProtocol
    
    init(dateService: DateServiceProtocol) {
        self.dateService = dateService
    }
    
    func map(_ model: [PictureOfTheDayNetworkModel]) -> [PictureOfTheDay] {
        model.compactMap(map(_:))
    }
    
    func map(lastDays: Int) -> (startDate: String, endDate: String)? {
        dateService.rangeForLast(days: lastDays, from: Date())
    }
    
    private func map(_ model: PictureOfTheDayNetworkModel) -> PictureOfTheDay? {
        guard let title = model.title else {
            return nil
        }
        
        let date = dateService.date(
            from: model.date ?? "",
            format: Date.networkDate
        )
        
        let dateLocalized = dateService.dateToLocalizedString(date: date)
        
        var mediaType: PictureOfTheDay.MediaType?
        let url = URL(string: model.url ?? "")
        
        switch model.mediaType {
        case .image:
            mediaType = .image(url: url)
        case .video:
            mediaType = .video(
                url: url,
                thumbnail: URL(string: model.thumbnailUrl ?? "")
            )
        default:
            break
        }

        return PictureOfTheDay(
            id: title,
            title: title,
            description: model.explanation,
            date: dateLocalized,
            author: model.copyright,
            type: mediaType
        )
    }
}
