//
//  PictureOfTheDayDetailsBuilder.swift
//  APOD
//
//  Created by Nikita Elizarov on 30.01.2022.
//

import Foundation
import SwiftUI

protocol PictureOfTheDayDetailsBuilderProtocol {
    func build(dependency: PictureOfTheDayDetailsViewModel.Dependency) -> PictureOfTheDayDetailsView
}

final class PictureOfTheDayDetailsBuilder: PictureOfTheDayDetailsBuilderProtocol {
    @ViewBuilder
    func build(dependency: PictureOfTheDayDetailsViewModel.Dependency) -> PictureOfTheDayDetailsView {
        PictureOfTheDayDetailsView(viewModel: .init(dependency: dependency))
    }
}

extension PictureOfTheDayDetailsBuilder {
    struct Dependency {
        let viewModel: PictureOfTheDayDetailsViewModel
    }
}
