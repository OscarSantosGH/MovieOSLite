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
        .task {
            await viewModel.config()
        }
        .ornament(visibility: .visible, attachmentAnchor: .scene(.bottom)) {
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
                
                Slider(value: $viewModel.currentTime, in: 0...viewModel.videoDuration) { editing in
                    if editing {
                        viewModel.youTubePlayer.pause()
                    } else {
                        viewModel.youTubePlayer.seek(to: viewModel.currentTime, allowSeekAhead: true)
                        viewModel.youTubePlayer.play()
                    }
                }
                .frame(width: 300)
                
                Text(viewModel.playbackTimeDisplay)
                    .frame(width: 100)
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
    
}

#Preview {
    MovieTrailerView(viewModel: MovieTrailerViewModel(trailer: VideoResponse.example))
}
