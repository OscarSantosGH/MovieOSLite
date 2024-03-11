//
//  PosterDetailView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct PosterDetailView: View {
    var posterPath: String
    var title: String
    var rating: Float
    
    var body: some View {
        VStack {
            MOImageLoaderView(imagePath: posterPath)
                .frame(height: 330)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            VStack(spacing: 10) {
                Text(title)
                    .frame(height: 40)
                    .font(.title2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                HStack {
                    Text(ratingText)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    if rating > 0 {
                        Spacer()
                        Text(String(rating))
                            .font(.headline)
                            .foregroundStyle(.orange)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .frame(width: 250, height: 420)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
    
    var ratingText: String {
        if rating == 0.0 {
            NSLocalizedString("Not Rated", comment: "When the movie isn't rated")
        }else{
            NSLocalizedString("Rating: ", comment: "Rating: ")
        }
    }
}

#Preview {
    PosterDetailView(posterPath: MovieResponse.example.posterPath!, title: MovieResponse.example.title, rating: MovieResponse.example.voteAverage)
}
