//
//  PosterDetailView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct PosterDetailView: View {
    var posterPath: String?
    var title: String
    var value: String
    var style: PosterStyle
    var action: (() -> Void)
    
    enum PosterStyle {
        case rating
        case subtitle
    }
    
    var body: some View {
        
        Button {
            action()
        } label: {
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
                    
                    if style == .subtitle {
                        Text(value)
                            .frame(height: 40)
                            .font(.title2)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .foregroundStyle(.orange)
                            .padding(.bottom)
                    } else {
                        HStack {
                            Text(ratingText)
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            
                            if value != "0.0" {
                                Spacer()
                                Text(value)
                                    .font(.headline)
                                    .foregroundStyle(.orange)
                            }
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
        .buttonStyle(.plain)
        .hoverEffectDisabled()
        
    }
    
    var ratingText: String {
        guard style == .rating else {
            return NSLocalizedString("Not Rated", comment: "When the movie isn't rated")
        }
        
        if value == "0.0" {
            return NSLocalizedString("Not Rated", comment: "When the movie isn't rated")
        } else {
            return NSLocalizedString("Rating: ", comment: "Rating: ")
        }
    }
}

#Preview {
    PosterDetailView(posterPath: MovieResponse.example.posterPath, title: MovieResponse.example.title, value: String(MovieResponse.example.voteAverage), style: .rating) {  }
}

#Preview {
    PosterDetailView(posterPath: MovieResponse.example.posterPath, title: MovieResponse.example.title, value: MovieResponse.example.originalTitle, style: .subtitle) {  }
}
