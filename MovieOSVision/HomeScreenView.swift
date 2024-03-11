//
//  HomeScreenView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct HomeScreenView: View {
    var popularMovies: [MovieResponse]
    var upcomingMovies: [MovieResponse]
    var nowPlayingMovies: [MovieResponse]
    var featuredMovies: [MovieResponse]
    
    var body: some View {
        VStack {
            // Featured movies
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(featuredMovies, id: \.id) { movie in
                        BannerMovieView(title: movie.title, imageURLPath: movie.backdropPath ?? "")
                            .frame(width: 450, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                }
                .padding()
            }
            
            //TODO: Popular movies
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let exampleMovieArray = Array(repeating: MovieResponse.example, count: 6)
    return HomeScreenView(popularMovies: exampleMovieArray,
                   upcomingMovies: exampleMovieArray,
                   nowPlayingMovies: exampleMovieArray,
                   featuredMovies: exampleMovieArray)
}
