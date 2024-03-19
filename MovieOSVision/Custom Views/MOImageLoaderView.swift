//
//  MOImageLoaderView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct MOImageLoaderView: View {
    private let basePath = "https://image.tmdb.org/t/p/"
    private let baseYoutubeThumbUrl = "https://img.youtube.com/vi/"
    var imagePath: String?
    var imageType: ImageType = .poster
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                switch imageType {
                case .backdrop:
                    LinearGradient(colors: [Color.purple, Color.red],
                                   startPoint: UnitPoint(x: 0, y: 0),
                                   endPoint: UnitPoint(x: 1, y: 1))
                    .scaledToFill()
                case .cast:
                    Image(.placeholderCast)
                        .resizable()
                        .scaledToFill()
                default:
                    Image(.posterPlaceholder)
                        .resizable()
                        .scaledToFill()
                }
            }
        }
        .task {
            let path = imagePath ?? ""
            switch imageType {
            case .backdrop:
                image = await TMDBClient.shared.downloadBackdropImage(from: path)
            case .poster:
                image = await TMDBClient.shared.downloadPosterImage(from: path)
            case .cast:
                image = await TMDBClient.shared.downloadCastImage(from: path)
            case .trailer:
                image = await TMDBClient.shared.downloadTrailerImage(from: path)
            }
        }
    }
    
    enum ImageType {
        case backdrop, poster, cast, trailer
    }
    
    private var imageSize: String {
        switch imageType {
        case .backdrop:
            "w300"
        case .poster, .cast:
            "w342"
        default: ""
        }
    }
    
    private var url: URL? {
        switch imageType {
        case .trailer:
            URL(string: baseYoutubeThumbUrl + (imagePath ?? "") + "/0.jpg")
        default: URL(string: basePath + imageSize + (imagePath ?? ""))
        }
    }
    
}

#Preview {
    MOImageLoaderView(imagePath: MovieResponse.example.posterPath)
}
