//
//  FavoritesScreenView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/21/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI
import SwiftData

struct FavoritesScreenView: View {
    @Query var movies: [Movie]
    @State private var selectedMovie: MovieDetailAPIResponse?
    
    private let columns = [
        GridItem(.adaptive(minimum: 250))
    ]
    
    var body: some View {
        NavigationStack {
            if movies.isEmpty {
                VStack(spacing: 15) {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    Text("noFavMovie")
                        .font(.title)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 50) {
                        ForEach(movies) { movie in
                            PosterDetailView(posterPath: movie.posterPath, title: movie.title, rating: movie.voteAverage) {
                                presentMovie(movie)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Favorites")
                .navigationDestination(item: $selectedMovie) { movie in
                    MovieDetailView(movie: movie)
                }
            }
        }

    }
    
    private func presentMovie(_ movie: Movie) {
        let movieDetail = MovieDetailAPIResponse(id: movie.id,
                               posterPath: movie.posterPath,
                               backdropPath: movie.backdropPath,
                               title: movie.title,
                               originalTitle: movie.originalTitle,
                               voteAverage: movie.voteAverage,
                               overview: movie.overview,
                               releaseDate: movie.releaseDate,
                               genres: movie.genreResponse,
                               credits: movie.creditsResponse,
                               videos: movie.videosResponse)
        selectedMovie = movieDetail
    }
}

#Preview {
    FavoritesScreenView()
}
