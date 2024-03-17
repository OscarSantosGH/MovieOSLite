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
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
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
