//
//  LoadingMoviesVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/29/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class LoadingMoviesVC: UIViewController {
    
    let backgroundViewImage = UIImageView(image: UIImage(named: "launchScreen"))
    let activityView = UIActivityIndicatorView(style: .large)
    let messageLabelView = MOTitleLabel(ofSize: 20, textAlignment: .center, textColor: .white)
    
    var popularMovies: [MovieResponse] = []
    var upcomingMovies: [MovieResponse] = []
    var nowPlayingMovies: [MovieResponse] = []
    var featuresMovies: [MovieResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        configure()
        NetworkManager.shared.checkForInternetConnection()
        NotificationCenter.default.addObserver(self, selector: #selector(checkForInternetConnection(notification:)), name: NotificationNames.internetAvailable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkForInternetConnection(notification:)), name: NotificationNames.internetNotAvailable, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configure(){
        backgroundViewImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewImage.contentMode = .scaleAspectFill
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.color = .white
        
        view.addSubviews(backgroundViewImage, activityView, messageLabelView)
        
        backgroundViewImage.pinToEdges(of: view)
        
        NSLayoutConstraint.activate([
            messageLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            messageLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            messageLabelView.heightAnchor.constraint(equalToConstant: 45),
            messageLabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.heightAnchor.constraint(equalToConstant: 50),
            activityView.widthAnchor.constraint(equalTo: activityView.heightAnchor),
            activityView.bottomAnchor.constraint(equalTo: messageLabelView.topAnchor, constant: -8)
            
        ])
        
        activityView.startAnimating()
        messageLabelView.text = NSLocalizedString("Getting movies...", comment: "MovieOS is downloading the movies")
    }
    
    private func setAppearance(){
        let value = UserDefaults.standard.integer(forKey: "appearance")
        guard let scene = UIApplication.shared.connectedScenes.first,
            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
            let window = windowSceneDelegate.window else {return}
        
        switch value {
        case 1:
            window?.overrideUserInterfaceStyle = .light
        case 2:
            window?.overrideUserInterfaceStyle = .dark
        default:
            window?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    @objc func checkForInternetConnection(notification:NSNotification){
        let isConnected = notification.name == NotificationNames.internetAvailable
        
        if isConnected{
            self.getPopularMovies()
        }else{
            self.messageLabelView.text = NSLocalizedString("Internet connection lost", comment: "No internet")
        }
    }
    
    
    func getPopularMovies() {
        messageLabelView.text = NSLocalizedString("Getting Popular movies...", comment: "MovieOS is downloading the popular movies")
        TMDBClient.shared.getMovies(from: .popular ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                self.messageLabelView.text = error.rawValue
            case .success(let movies):
                self.popularMovies = movies
                self.getUpcomingMovies()
            }
        }
    }
    
    func getUpcomingMovies() {
        messageLabelView.text = NSLocalizedString("Getting Upcoming movies...", comment: "MovieOS is downloading the upcoming movies")
        TMDBClient.shared.getMovies(from: .upcoming ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                self.messageLabelView.text = error.rawValue
            case .success(let movies):
                self.upcomingMovies = movies.shuffled()
                self.getNowPlayingMovies()
            }
        }
    }
    
    func getNowPlayingMovies() {
        messageLabelView.text = NSLocalizedString("Getting playing now movies...", comment: "MovieOS is downloading the now playing movies")
        TMDBClient.shared.getMovies(from: .nowPlaying ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                self.messageLabelView.text = error.rawValue
            case .success(let movies):
                self.nowPlayingMovies = movies.shuffled()
                self.getFeaturesMovies()
            }
        }
    }
    
    func getFeaturesMovies(){
        messageLabelView.text = NSLocalizedString("Getting Featured Movies...", comment: "MovieOS is downloading featured movies")
        TMDBClient.shared.getMovies(from: .topRated ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                self.messageLabelView.text = error.rawValue
            case .success(let movies):
                self.featuresMovies = movies.shuffled()
                self.goToHome()
            }
        }
    }
    
    private func goToHome(){
        messageLabelView.text = NSLocalizedString("Welcome to MovieOS", comment: "welcome to MovieOS")
        let tabBar = MOTabBarController(popularMovies: popularMovies, upcomingMovies: upcomingMovies, nowPlayingMovies: nowPlayingMovies, featuresMovies: featuresMovies)
        show(tabBar, sender: self)
    }
    
    

}
