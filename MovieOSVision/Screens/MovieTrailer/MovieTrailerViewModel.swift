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
    var videoDuration: Double = 0
    var currentTime: Double = 0
    var playbackTimeDisplay: String = "0:00 / 0:00"
    
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
        
    }
    
    func config() async {
        do {
            self.videoDuration = try await self.youTubePlayer.getDuration()
        } catch {
            //TODO: handle error
            print("error getting video duration: \(error.localizedDescription)")
        }
        
        self.youTubePlayer.playbackStatePublisher
            .sink { [self] state in
                self.playbackState = state
            }
            .store(in: &cancellables)
        
        self.youTubePlayer.currentTimePublisher()
            .sink { [self] currentTime in
                self.currentTime = currentTime
                self.setPlaybackTime()
            }
            .store(in: &cancellables)
    }
    
    private func setPlaybackTime() {
        let totalTime = formatSecondsToMinutesAndSeconds(seconds: videoDuration)
        let currentTimeString = formatSecondsToMinutesAndSeconds(seconds: currentTime)
        
        playbackTimeDisplay = "\(currentTimeString) / \(totalTime)"
    }
    
    private func formatSecondsToMinutesAndSeconds(seconds: Double) -> String {
        let totalSeconds = Int(seconds.rounded(.up))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
}
