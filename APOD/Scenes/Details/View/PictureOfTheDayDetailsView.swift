//
//  PictureOfTheDayDetailsView.swift
//  APOD
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import SwiftUI

struct PictureOfTheDayDetailsView: View {
    @ObservedObject var viewModel: PictureOfTheDayDetailsViewModel

    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(viewModel.title, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { viewModel.handleEvent(.onDismiss) }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }
                    }
                }
        }
        .onAppear {
            withAnimation(.easeOut) {
                viewModel.handleEvent(.onAppear)
            }
        }
    }

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()
        case let .loaded(details):
            detailsView(for: details)
        }
    }

    private func detailsView(for details: PictureOfTheDay) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                if let videoURL = details.videoURL {
                    Link(destination: videoURL) {
                        ZStack {
                            ImageView(
                                url: details.image
                            )
                            .edgesIgnoringSafeArea(.all)
                            .frame(maxWidth: .infinity)
                            .frame(height: 350)

                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(.white)
                        }
                    }
                } else {
                    ImageView(
                        url: details.image
                    )
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity)
                    .frame(height: 350)
                    .contextMenu {
                        // TODO: Should be changed to share text, image
                        Link(destination: details.image ?? URL(fileURLWithPath: "")) {
                            Label("Open the original", systemImage: "photo")
                        }
                    }
                }

                HStack {
                    Text(details.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)

                    Spacer()

                    Button(action: { viewModel.handleEvent(.onFavorite) }) {
                        Image(systemName: "heart.circle")
                            .font(.subheadline)
                    }
                }
            }
            .padding(10)
            .foregroundColor(.white)
            .background(
                Color(.black)
                    .cornerRadius(12)
            )
            .textSelection(.enabled)
            .padding(10)

            VStack(spacing: 15) {
                HStack(alignment: .top) {
                    details.date.map {
                        section(
                            title: "Date taken",
                            description: $0
                        )
                    }

                    Spacer()

                    details.author.map { title in
                        section(
                            title: "Author",
                            description: title + " ©"
                        )
                    }
                }

                details.description.map {
                    section(
                        title: "Description",
                        description: $0
                    )
                }
            }
            .padding(.horizontal)
        }
        .frame(
            maxHeight: .infinity,
            alignment: .top
        )
    }

    private func section(title: String, description: String) -> some View {
        VStack(spacing: 10) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)

            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .textSelection(.enabled)
        }
    }
}
