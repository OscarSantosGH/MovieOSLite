//
//  MOImageLoaderView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct MOImageLoaderView: View {
    let basePath = "https://image.tmdb.org/t/p/"
    var imagePath: String
    var imageType: ImageType = .poster
    
    var body: some View {
        AsyncImage(url: URL(string: basePath+imageSize+imagePath)) { image in
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
    
    private var imageSize: String {
        switch imageType {
        case .backdrop:
            "w300"
        case .poster, .cast:
            "w342"
        }
    }
}

#Preview {
    MOImageLoaderView(imagePath: MovieResponse.example.posterPath!)
}
