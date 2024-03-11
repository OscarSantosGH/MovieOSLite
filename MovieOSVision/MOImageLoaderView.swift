//
//  MOImageLoaderView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct MOImageLoaderView: View {
    let basePath = "https://image.tmdb.org/t/p/original/"
    var imagePath: String
    var imageType: ImageType = .poster
    
    var body: some View {
        AsyncImage(url: URL(string: basePath+imagePath)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            switch imageType {
            case .backdrop:
                LinearGradient(colors: [Color.purple, Color.red],
                               startPoint: UnitPoint(x: 0, y: 0),
                               endPoint: UnitPoint(x: 1, y: 1))
            case .poster:
                Image(.posterPlaceholder)
                    .resizable()
                    .scaledToFill()
            case .cast:
                Image(.placeholderCast)
                    .resizable()
                    .scaledToFill()
            }
        }
    }
    
    enum ImageType {
        case backdrop, poster, cast
    }
}

#Preview {
    MOImageLoaderView(imagePath: MovieResponse.example.posterPath!)
}
