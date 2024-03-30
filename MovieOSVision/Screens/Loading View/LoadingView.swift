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
        if loadingViewModel.showHomeView {
            MainTabView(popularMovies: loadingViewModel.popularMovies.shuffled(),
                           upcomingMovies: loadingViewModel.upcomingMovies.shuffled(),
                           nowPlayingMovies: loadingViewModel.nowPlayingMovies.shuffled(),
                           featuredMovies: loadingViewModel.featuredMovies)
        } else {
            VStack {
                Text(loadingViewModel.messageText)
            }
            .padding()
            .task {
                await loadingViewModel.getMovies()
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    LoadingView()
}
