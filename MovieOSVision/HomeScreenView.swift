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
    @State private var selectedMovie: MovieResponse?
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                // Featured movies
                //TODO: Implement pagination behavior
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(featuredMovies, id: \.id) { movie in
                            BannerMovieView(movie: movie)
                                .frame(width: geo.size.width * 0.95)
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
                            PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage) {
                                selectedMovie = movie
                            }
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
                            PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage) {
                                selectedMovie = movie
                            }
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
                            PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage) {
                                selectedMovie = movie
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(item: $selectedMovie) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}

#Preview {
    let exampleMovieArray = Array(repeating: MovieResponse.example, count: 6)
    return HomeScreenView(popularMovies: exampleMovieArray,
                          upcomingMovies: exampleMovieArray,
                          nowPlayingMovies: exampleMovieArray,
                          featuredMovies: exampleMovieArray)
}
