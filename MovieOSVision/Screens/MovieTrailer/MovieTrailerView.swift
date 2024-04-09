//
//  MovieTrailerView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/5/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI
import YouTubePlayerKit

struct MovieTrailerView: View {
    @State var viewModel: MovieTrailerViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            YouTubePlayerView(viewModel.youTubePlayer) { state in
                switch state {
                case .idle:
                    ProgressView()
                case .ready:
                    EmptyView()
                case .error(let error):
                    Text(verbatim: "YouTube player couldn't be loaded")
                        .onAppear{
                            print(error.localizedDescription)
                        }
                }
            }
            .ignoresSafeArea()
        }
        //TODO: Create video controls using ornament
        .ornament(attachmentAnchor: .scene(.bottom)) {
            HStack {
                Button {
                    if viewModel.playbackState == .playing {
                        viewModel.youTubePlayer.pause()
                    } else {
                        viewModel.youTubePlayer.play()
                    }
                } label: {
                    Image(systemName: viewModel.playbackState == .playing ? "pause.fill" : "play.fill")
                }
            }
            .padding()
        }
    }
    
}

#Preview {
    MovieTrailerView(viewModel: MovieTrailerViewModel(trailer: VideoResponse.example))
}
