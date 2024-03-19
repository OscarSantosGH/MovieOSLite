//
//  LoadingView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/4/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
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
                HomeScreenView(popularMovies: loadingViewModel.popularMovies.shuffled(),
                               upcomingMovies: loadingViewModel.upcomingMovies.shuffled(),
                               nowPlayingMovies: loadingViewModel.nowPlayingMovies.shuffled(),
                               featuredMovies: loadingViewModel.featuredMovies)
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    LoadingView()
}
