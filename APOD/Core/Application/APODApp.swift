//
//  APODApp.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Networking
import SwiftUI

@main
struct APODApp: App {
    private let networkClient: NetworkingProtocol = Client()
    private let realmManager: RealmManagerProtocol = RealmManager()

    var body: some Scene {
        WindowGroup {
            TabView {
                PictureOfTheDayListBuilder(
                    dependency: .init(
                        viewModel: .init(
                            dependency: .init(
                                type: .list,
                                mapper: PictureOfTheDayListMapper(
                                    dateService: DateService(locale: Locale.current)
                                ),
                                interactor: PictureOfTheDayListInteractor(
                                    networkClient: networkClient,
                                    repository: PictureOfTheDayRepository(realmManager: realmManager)
                                ),
                                scheduler: .main
                            )
                        )
                    )
                )
                .build()
                .tabItem {
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("Pictures")
                }

                PictureOfTheDayListBuilder(
                    dependency: .init(
                        viewModel: .init(
                            dependency: .init(
                                type: .favorites,
                                mapper: PictureOfTheDayListMapper(
                                    dateService: DateService(locale: Locale.current)
                                ),
                                interactor: PictureOfTheDayListInteractor(
                                    networkClient: networkClient,
                                    repository: PictureOfTheDayRepository(realmManager: realmManager)
                                ),
                                scheduler: .main
                            )
                        )
                    )
                )
                .build()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            }
        }
    }
}
