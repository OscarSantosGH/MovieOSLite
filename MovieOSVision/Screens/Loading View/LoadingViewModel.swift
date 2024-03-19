//
//  LoadingViewModel.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/8/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

@Observable
class LoadingViewModel {
    var popularMovies: [MovieResponse] = []
    var upcomingMovies: [MovieResponse] = []
    var nowPlayingMovies: [MovieResponse] = []
    var featuredMovies: [MovieResponse] = []
    var messageText: String = ""
    var showHomeView = false
    
    func getMovies() async {
        messageText = NSLocalizedString("Getting Popular movies...", comment: "MovieOS is downloading the popular movies")
        let popularMoviesResult = await TMDBClient.shared.getMovies(from: .popular)
        popularMovies = processMoviesResult(popularMoviesResult)
        
        messageText = NSLocalizedString("Getting Upcoming movies...", comment: "MovieOS is downloading the upcoming movies")
        let upcomingMoviesResult = await TMDBClient.shared.getMovies(from: .upcoming)
        upcomingMovies = processMoviesResult(upcomingMoviesResult)
        
        messageText = NSLocalizedString("Getting playing now movies...", comment: "MovieOS is downloading the now playing movies")
        let nowPlayingMoviesResult = await TMDBClient.shared.getMovies(from: .nowPlaying)
        nowPlayingMovies = processMoviesResult(nowPlayingMoviesResult)
        
        messageText = NSLocalizedString("Getting Featured Movies...", comment: "MovieOS is downloading featured movies")
        let featuresMoviesResult = await TMDBClient.shared.getMovies(from: .topRated)
        featuredMovies = processMoviesResult(featuresMoviesResult)
        
        messageText = NSLocalizedString("Welcome to MovieOS", comment: "welcome to MovieOS")
        showHomeView = true
    }
    
    private func processMoviesResult(_ result: Result<[MovieResponse], MOError>) -> [MovieResponse] {
        switch result{
        case .failure(let error):
            messageText = error.rawValue
            return []
        case .success(let movies):
            return movies
        }
    }
}
