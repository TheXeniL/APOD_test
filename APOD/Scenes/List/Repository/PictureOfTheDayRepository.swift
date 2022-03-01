//
//  PictureOfTheDayRepository.swift
//  APOD
//
//  Created by Nikita Elizarov on 03.02.2022.
//

import Combine
import Foundation
import RealmSwift

final class PictureOfTheDayRepository: PictureOfTheDayRepositoryProtocol {
    private weak var realmManager: RealmManagerProtocol?

    private var pictureOfTheDayFavorites: Results<PictureOfTheDayDB>? {
        realmManager?.localStorage?.objects(PictureOfTheDayDB.self)
    }

    var favorites: [PictureOfTheDay] {
        guard let data = pictureOfTheDayFavorites else {
            return []
        }

        return data.map(PictureOfTheDay.init)
    }

    init(realmManager: RealmManagerProtocol?) {
        self.realmManager = realmManager
    }

    func toggleFavorite(for model: PictureOfTheDay) -> Future<Void, Error> {
        guard pictureOfTheDayFavorites?.contains(where: { $0.id == model.id }) == true else {
            return add(model)
        }

        return remove(model.id)
    }

    // MARK: - CRUD

    func add(_ model: PictureOfTheDay) -> Future<Void, Error> {
        Future { [weak self] promise in
            do {
                let realm = self?.realmManager?.localStorage

                let storageModel = PictureOfTheDayDB()
                var type: String?
                var contentURL: String?
                var thumbnailURL: String?

                switch model.type {
                case let .video(url, thumbnail):
                    type = "video"
                    contentURL = url?.absoluteString
                    thumbnailURL = thumbnail?.absoluteString
                case let .image(url):
                    type = "image"
                    contentURL = url?.absoluteString
                default:
                    break
                }

                storageModel.id = model.id
                storageModel.title = model.title
                storageModel.subtitle = model.description ?? ""
                storageModel.date = model.date ?? ""
                storageModel.author = model.author ?? ""
                storageModel.mediaType = type ?? ""
                storageModel.contentURL = contentURL ?? ""
                storageModel.thumbnailURL = thumbnailURL ?? ""

                try realm?.write {
                    realm?.add(storageModel)
                    promise(.success(()))
                }
            } catch {
                promise(.failure(error))
            }
        }
    }

    func remove(_ id: String) -> Future<Void, Error> {
        Future { [weak self] promise in
            guard
                let storageModel = self?.pictureOfTheDayFavorites?.first(where: { $0.id == id })
            else {
                return
            }

            do {
                let realm = self?.realmManager?.localStorage
                try realm?.write {
                    realm?.delete(storageModel)
                    promise(.success(()))
                }
            } catch {
                promise(.failure(error))
            }
        }
    }
}
