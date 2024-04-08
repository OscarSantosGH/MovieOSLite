//
//  SearchScreenViewModel.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/31/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import Foundation

@Observable
class SearchScreenViewModel {
    var isLoadingMovies = false
    var movies: [MovieResponse] = []
    var totalPages: Int = 0
    var selectedMovie: MovieDetailAPIResponse?
    private var selectedMovieTask: Task<Void, Error>?
    
    //TODO: Manage Task locally for canceling current running task and replace it with the new one
    func getMoviesByCategory(withCategoryURL categoryURL: String) async {
        isLoadingMovies = true
        let (moviesResult, totalPages) = await TMDBClient.shared.getMoviesBy(txt: categoryURL)
        isLoadingMovies = false
        
        switch moviesResult {
        case .success(let movies):
            self.movies = movies
            self.totalPages = totalPages
        case .failure(let error):
            print("Error loading movies: \(error.localizedDescription)")
            self.totalPages = 0
        }
        
    }
    
    func getMoviesBySearch(movieName: String) async {
        isLoadingMovies = true
        let (moviesResult, totalPages) = await TMDBClient.shared.searchMovies(withString: movieName)
        isLoadingMovies = false
        
        switch moviesResult {
        case .success(let movies):
            self.movies = movies
            self.totalPages = totalPages
        case .failure(let error):
            print("Error loading movies: \(error.localizedDescription)")
            self.totalPages = 0
        }
    }
    
    func presentMovieDetails(movie: MovieResponse) {
        //TODO: Make some loading animation while downloading the movie details
        selectedMovieTask?.cancel()
        selectedMovieTask = Task {
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
