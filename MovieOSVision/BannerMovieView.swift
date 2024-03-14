//
//  BannerMovieView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/8/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct BannerMovieView: View {
    let movie: MovieResponse
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(NSLocalizedString("Release Date", comment: "Release Date")+":")
                        Text(configureReleaseDate(from: movie.releaseDate))
                    }
                    
                    Text(movie.title)
                        .font(.extraLargeTitle)
                    
                    Text(movie.overview)
                        .lineLimit(3)
                        .padding(.top)
                    
                }
                .padding(.trailing)
                
                Spacer()
                
                MOImageLoaderView(imagePath: movie.posterPath ?? "", imageType: .poster)
                    .frame(width: 250, height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
            .padding()
            .padding(.horizontal, 25)
        }
        .background {
            MOImageLoaderView(imagePath: movie.backdropPath ?? "", imageType: .backdrop)
                .overlay(Material.regular)
        }
        .frame(minWidth: 800, minHeight: 400)
        .clipShape(RoundedRectangle(cornerRadius: 35))
    }
    
    //TODO: refactor this method to reuse in other views
    private func configureReleaseDate(from stringDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:stringDate) else {return NSLocalizedString("Unknown", comment: "Unknown")}
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, yyyy"
        
        return newFormatter.string(from: date)
    }
}

#Preview {
    BannerMovieView(movie: MovieResponse.example)
}
