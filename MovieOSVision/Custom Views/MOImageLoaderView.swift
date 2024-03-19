//
//  MOImageLoaderView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct MOImageLoaderView: View {
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
    
}

#Preview {
    MOImageLoaderView(imagePath: MovieResponse.example.posterPath)
}
