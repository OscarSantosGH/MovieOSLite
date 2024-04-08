//
//  MovieTrailerViewModel.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/6/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import Foundation
import YouTubePlayerKit

@Observable
class MovieTrailerViewModel {
    let trailer: VideoResponse
    var youTubePlayer: YouTubePlayer
    
    init(trailer: VideoResponse) {
        self.trailer = trailer
        let config = YouTubePlayer.Configuration(
            allowsPictureInPictureMediaPlayback: true,
            fullscreenMode: .web,
            autoPlay: true,
            showControls: true,
            showFullscreenButton: true,
            showAnnotations: false,
            loopEnabled: false,
            useModestBranding: true,
            playInline: true
        )
        self.youTubePlayer = YouTubePlayer(source: .video(id: trailer.key), configuration: config)
    }
    
}
