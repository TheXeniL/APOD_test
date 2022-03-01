//
//  ImageView.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Kingfisher
import SwiftUI

struct ImageView: View {
    let url: URL?
    let sampling: CGSize
    
    init(
        url: URL?,
        sampling: CGSize = CGSize(width: 350, height: 350)
    ) {
        self.url = url
        self.sampling = sampling
    }

    var placeholderImage: KFCrossPlatformImage? {
        .init(systemName: "photo.circle")
    }

    var body: some View {
        KFImage(url)
            .placeholder { _ in
                ProgressView()
            }
            .downsampling(size: sampling)
            .cacheOriginalImage()
            .retry(maxCount: 3, interval: .seconds(5))
            .onFailureImage(placeholderImage)
            .resizable()
            .cancelOnDisappear(true)
            .aspectRatio(1, contentMode: .fit)
    }
}
