//
//  MOPlayerViewController.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 10/3/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import AVKit
import YoutubeDirectLinkExtractor

class MOPlayerViewController {
    
    static let shared = MOPlayerViewController()
    
    var playerVC = AVPlayerViewController()
    var ytPlayer = AVPlayer()
    var isPlaying = false
    
    private init(){
        playerVC.allowsPictureInPicturePlayback = true
        ytPlayer.allowsExternalPlayback = true
        ytPlayer.isMuted = false
        ytPlayer.automaticallyWaitsToMinimizeStalling = false
    }
    
    func playVideoWithKey(key: String, completion: @escaping ()->Void){
        let y = YoutubeDirectLinkExtractor()
        y.extractInfo(for: .id(key), success: { [weak self] info in
            guard let self = self else {return}
            DispatchQueue.main.async {
                guard let link = info.highestQualityPlayableLink,
                      let url = URL(string: link) else {return}
                self.ytPlayer.replaceCurrentItem(with: AVPlayerItem(url: url))
                self.playerVC.player = self.ytPlayer
                self.playerVC.player?.play()
                completion()
            }
        }) { error in
            print(error)
        }
    }

}
