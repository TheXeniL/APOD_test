//
//  PictureOfTheDayParameters.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

struct PictureOfTheDayParameters {
    let filter: Filter?

    enum Filter {
        case date(String)
        case count(String)
        case range(startDate: String, endDate: String)
    }
}
