//
//  MovieTrailerViewModel.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/6/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import Foundation
import YouTubePlayerKit
import Combine

@Observable
class MovieTrailerViewModel {
    let trailer: VideoResponse
    var youTubePlayer: YouTubePlayer
    var playbackState: YouTubePlayer.PlaybackState?
    private var cancellables = Set<AnyCancellable>()
    
    init(trailer: VideoResponse) {
        self.trailer = trailer
        let config = YouTubePlayer.Configuration(
            autoPlay: true,
            showControls: false,
            showAnnotations: false,
            loopEnabled: false,
            useModestBranding: true,
            playInline: false
        )
        self.youTubePlayer = YouTubePlayer(source: .video(id: trailer.key), configuration: config)
        self.youTubePlayer.playbackStatePublisher
            .sink { [self] state in
                self.playbackState = state
            }
            .store(in: &cancellables)
    }
    
}
