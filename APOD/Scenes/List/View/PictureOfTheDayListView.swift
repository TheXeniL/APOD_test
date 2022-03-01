//
//  ContentView.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import SwiftUI

struct PictureOfTheDayListView: View {
    @ObservedObject var viewModel: PictureOfTheDayListViewModel

    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150), spacing: 10)]
    }

    var body: some View {
        content
            .sheet(
                item: $viewModel.pictureOfTheDayDetails,
                onDismiss: {}
            ) { item in
                PictureOfTheDayDetailsBuilder()
                    .build(
                        dependency: .init(
                            pictureOfTheDay: item,
                            onDismiss: {
                                viewModel.handleEvent(.onDismissDetails)
                            }, onToggleFavorite: { model in
                                viewModel.handleEvent(.onToggleFavorite(model))
                            }
                        )
                    )
            }
            .onAppear(perform: viewModel.onAppear)
    }

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            VStack(spacing: 10) {
                Spacer()

                Text("Empty")

                Spacer()
            }
            .foregroundColor(.gray)
        case let .loaded(data):
            if data.isEmpty {
                VStack(spacing: 10) {
                    Spacer()

                    Text("Empty")

                    Spacer()
                }
                .foregroundColor(.gray)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(data) { item in
                            PictureOfTheDayCellView(model: item) {
                                viewModel.handleEvent(.onPresentDetails(item))
                            }
                        }
                    }
                    .padding(20)
                }
            }
        case .loading:
            VStack(spacing: 10) {
                Spacer()

                ProgressView()

                Text("Loading data...")

                Spacer()
            }
            .foregroundColor(.gray)
        case let .error(error):
            VStack(spacing: 10) {
                Text("Failed to load the data")

                Text(error.localizedDescription)

                Button(action: { viewModel.handleEvent(.onRetry) }) {
                    Text("Retry")
                }
                .padding(.top, 20)
            }
        }
    }
}
