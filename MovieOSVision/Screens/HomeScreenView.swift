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
    @State private var selectedMovie: MovieDetailAPIResponse?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    // Featured movies
                    //TODO: Implement pagination behavior
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(featuredMovies, id: \.id) { movie in
                                FeatureMovieView(movie: movie) {
                                    presentMovieDetails(movie: movie)
                                }
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
                        LazyHStack(spacing: 10) {
                            ForEach(popularMovies, id: \.id) { movie in
                                PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage) {
                                    presentMovieDetails(movie: movie)
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
                        LazyHStack(spacing: 10) {
                            ForEach(nowPlayingMovies, id: \.id) { movie in
                                PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage) {
                                    presentMovieDetails(movie: movie)
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
                        LazyHStack(spacing: 10) {
                            ForEach(upcomingMovies, id: \.id) { movie in
                                PosterDetailView(posterPath: movie.posterPath ?? "", title: movie.title, rating: movie.voteAverage) {
                                    presentMovieDetails(movie: movie)
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
    
    private func presentMovieDetails(movie: MovieResponse) {
        //TODO: Make some loading animation while downloading the movie details
        Task {
            let response = await TMDBClient.shared.getMovie(withID: movie.id)
            
            switch response {
            case .success(let movieDetails):
                selectedMovie = movieDetails
            case .failure(let error):
                //TODO: Create a view to display some message to the user to informed that the movie details fetching fails
                print("Error getting movie details: \(error)")
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
