//
//  PictureOfTheDayListBuilder.swift
//  APOD
//
//  Created by Nikita Elizarov on 30.01.2022.
//

import Foundation
import SwiftUI

protocol PictureOfTheDayListBuilderProtocol {
    func build() -> PictureOfTheDayListView
}

final class PictureOfTheDayListBuilder: PictureOfTheDayListBuilderProtocol {
    let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    @ViewBuilder
    func build() -> PictureOfTheDayListView {
        PictureOfTheDayListView(
            viewModel: dependency.viewModel
        )
    }
}

extension PictureOfTheDayListBuilder {
    struct Dependency {
        let viewModel: PictureOfTheDayListViewModel
    }
}
