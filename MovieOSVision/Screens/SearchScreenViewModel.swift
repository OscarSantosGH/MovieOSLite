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
}
