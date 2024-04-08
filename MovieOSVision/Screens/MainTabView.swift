//
//  MainTabView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/20/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var popularMovies: [MovieResponse]
    var upcomingMovies: [MovieResponse]
    var nowPlayingMovies: [MovieResponse]
    var featuredMovies: [MovieResponse]
    
    var body: some View {
        TabView {
            HomeScreenView(popularMovies: popularMovies, upcomingMovies: upcomingMovies, nowPlayingMovies: nowPlayingMovies, featuredMovies: featuredMovies)
                .tabItem {
                    Label("Home", systemImage: "film")
                }
            
            SearchScreenView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    let exampleMovieArray = Array(repeating: MovieResponse.example, count: 6)
    return MainTabView(popularMovies: exampleMovieArray,
                          upcomingMovies: exampleMovieArray,
                          nowPlayingMovies: exampleMovieArray,
                          featuredMovies: exampleMovieArray)
}
