//
//  PictureOfTheDayCellView.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import SwiftUI

struct PictureOfTheDayCellView: View {
    let model: PictureOfTheDay
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 20) {
                ImageView(
                    url: model.image,
                    sampling: CGSize(width: 150, height: 150)
                )
                .padding()

                Text(model.title)
                    .font(.headline)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            .frame(minWidth: 150)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(
                color: Color.black.opacity(0.1),
                radius: 10,
                x: 0,
                y: 4
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PushButtonStyle())
    }
}

struct PictureOfTheDayCellView_Previews: PreviewProvider {
    static var previews: some View {
        PictureOfTheDayCellView(
            model: .init(title: "Western Moon, Eastern Sea"),
            onTap: {}
        )
    }
}
