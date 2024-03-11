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
        ScrollView {
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
            
            //Popular movies
            Text(NSLocalizedString("Popular", comment: "popular category"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(popularMovies, id: \.id) { movie in
                        PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage)
                    }
                }
                .padding()
            }
            
            //Now playing movies
            Text(NSLocalizedString("Now Playing", comment: "now playing category"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(nowPlayingMovies, id: \.id) { movie in
                        PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage)
                    }
                }
                .padding()
            }
            
            //Upcoming movies
            Text(NSLocalizedString("Upcoming", comment: "upcoming category"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(upcomingMovies, id: \.id) { movie in
                        PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage)
                    }
                }
                .padding()
            }
            
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
