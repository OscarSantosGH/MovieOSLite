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
    var isPlaying = false
    let maxHeight:CGFloat = 240
    
    private let activityView = UIActivityIndicatorView(style: .large)
    private var closeBtn = UIButton()
    private(set) lazy var playerState = { [weak self] in
        self?.playerVC.player.playbackState
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        configurePlayer()
        createCloseButton()
        configureLayout()
    }
    
    private func configurePlayer(){
        let configuration = YouTubePlayer.Configuration(
            fullscreenMode: .system,
            autoPlay: true,
            showControls: true,
            loopEnabled: false,
            playInline: true
        )
        
        let player = YouTubePlayer(configuration: configuration)
        playerVC = YouTubePlayerViewController(player: player)
        playerVC.player.source = .video(id: "xwYNVhFJyYk")
        addChild(playerVC)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCloseButton() {
        closeBtn = UIButton(type: .system, primaryAction: .init(title: "Close",
                                                                image: UIImage(systemName: "xmark.circle"),
                                                                handler: { [weak self] _ in
            guard let self = self else { return }
            self.closePlayer {}
        }))
        closeBtn.tintColor = .label
    }
    
    private func configureLayout() {
        view.addSubview(playerVC.view)
        playerVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            playerVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerVC.view.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
            closeBtn.heightAnchor.constraint(equalToConstant: 40),
            closeBtn.bottomAnchor.constraint(equalTo: playerVC.view.topAnchor)
        ])
        
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func closePlayer(_ completion: @escaping () -> Void) {
        print("closePlayer action")
        playerVC.player.stop()
        completion()
    }
    
    func playVideoWithKey(key: String){
        playerVC.player.source = .video(id: key)
        playerVC.player.play()
    }
    
}
