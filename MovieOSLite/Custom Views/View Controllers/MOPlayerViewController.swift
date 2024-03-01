//
//  MOPlayerViewController.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 10/3/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import AVKit
import YouTubePlayerKit

class MOPlayerViewController: UIViewController {
    
    var playerVC: YouTubePlayerViewController!
    var isOpen = false
    let maxHeight:CGFloat = 240
    
    private let activityView = UIActivityIndicatorView(style: .large)
    private(set) lazy var playerState = { [weak self] in
        self?.playerVC.player.playbackState
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        configurePlayer()
        configureLayout()
    }
    
    private func configurePlayer(){
        let configuration = YouTubePlayer.Configuration(
            fullscreenMode: .system,
            autoPlay: true,
            showControls: true,
            showAnnotations: false,
            loopEnabled: false,
            useModestBranding: true,
            playInline: true
        )
        
        let player = YouTubePlayer(configuration: configuration)
        playerVC = YouTubePlayerViewController(player: player)
        addChild(playerVC)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePlayer))
        navigationItem.rightBarButtonItem = doneButton
        view.addSubview(playerVC.view)
        playerVC.view.translatesAutoresizingMaskIntoConstraints = false
        playerVC.view.pinToEdgesWithSafeArea(of: view)
        
        view.backgroundColor = .black
    }
    
    @objc private func closePlayer() {
        playerVC.player.stop()
        dismiss(animated: true)
    }
    
    func playVideoWithKey(key: String){
        playerVC.player.source = .video(id: key)
        playerVC.player.play()
    }
    
}
