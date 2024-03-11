//
//  ContentView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/4/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loadingViewModel = LoadingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(loadingViewModel.messageText)
            }
            .padding()
            .task {
                await loadingViewModel.getMovies()
            }
            .navigationDestination(isPresented: $loadingViewModel.showHomeView) {
                HomeScreenView(popularMovies: loadingViewModel.popularMovies,
                               upcomingMovies: loadingViewModel.upcomingMovies,
                               nowPlayingMovies: loadingViewModel.nowPlayingMovies,
                               featuredMovies: loadingViewModel.featuredMovies)
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
