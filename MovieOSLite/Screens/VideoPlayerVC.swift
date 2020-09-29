//
//  VideoPlayerVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import YoutubeDirectLinkExtractor
import AVKit

class VideoPlayerVC: AVPlayerViewController{
    
    var ytPlayer = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        allowsPictureInPicturePlayback = true
        ytPlayer.allowsExternalPlayback = true
        ytPlayer.isMuted = false
        ytPlayer.automaticallyWaitsToMinimizeStalling = false
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func playVideoWithKey(key: String){
        showLoadingState()
        let y = YoutubeDirectLinkExtractor()
        y.extractInfo(for: .id(key), success: { [weak self] info in
            guard let self = self else {return}
            self.hideLoadingState()
            DispatchQueue.main.async {
                guard let link = info.highestQualityPlayableLink,
                      let url = URL(string: link) else {return}
                self.ytPlayer = AVPlayer(url: url)
                self.player = self.ytPlayer
                self.player?.play()
            }
        }) { error in
            print(error)
        }
    }

}
