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
    var videoID: String
    
    var body: some View {
        YouTubePlayerView(self.youTubePlayer) { state in
            switch state {
            case .idle:
                ProgressView()
            case .ready:
                EmptyView()
            case .error(let error):
                Text(verbatim: "YouTube player couldn't be loaded")
            }
        }
    }
    
    private var youTubePlayer: YouTubePlayer {
    //TODO: Make a proper video configuration
        return YouTubePlayer(source: .video(id: videoID))
    }
}

#Preview {
    MovieTrailerView(videoID: "psL_5RIBqnY")
}
