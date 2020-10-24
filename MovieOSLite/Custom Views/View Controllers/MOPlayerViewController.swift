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
    let activityView = UIActivityIndicatorView(style: .large)
    var isPlaying = false
    var isOnPictureInPictureMode = false
    
    private init(){
        playerVC.allowsPictureInPicturePlayback = true
        ytPlayer.allowsExternalPlayback = true
        ytPlayer.isMuted = false
        ytPlayer.automaticallyWaitsToMinimizeStalling = false
    }
    
    func playVideoWithKey(key: String){
        playerVC.contentOverlayView?.addSubview(activityView)
        activityView.center = playerVC.contentOverlayView?.center ?? CGPoint(x: 0.5, y: 0.5)
        activityView.startAnimating()
        let y = YoutubeDirectLinkExtractor()
        y.extractInfo(for: .id(key), success: { [weak self] info in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.activityView.removeFromSuperview()
                guard let link = info.highestQualityPlayableLink,
                      let url = URL(string: link) else {return}
                self.ytPlayer.replaceCurrentItem(with: AVPlayerItem(url: url))
                self.playerVC.player = self.ytPlayer
                self.playerVC.player?.play()
            }
        }) { error in
            print(error)
        }
    }
    
    func playVideoWithKey(key: String, completion: @escaping ()->Void){
        playerVC.contentOverlayView?.addSubview(activityView)
        activityView.center = playerVC.contentOverlayView?.center ?? CGPoint(x: 0.5, y: 0.5)
        activityView.startAnimating()
        let y = YoutubeDirectLinkExtractor()
        y.extractInfo(for: .id(key), success: { [weak self] info in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.activityView.removeFromSuperview()
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
