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
        configure()
        getPopularMovies()
    }
    
    private func configure(){
        backgroundViewImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewImage.contentMode = .scaleAspectFill
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
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
        messageLabelView.text = "Loading Movies..."
    }
    
    
    func getPopularMovies() {
        messageLabelView.text = "Loading Popular Movies..."
        NetworkManager.shared.getMovies(from: .popular ) { [weak self] (result) in
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
        messageLabelView.text = "Loading Upcoming Movies..."
        NetworkManager.shared.getMovies(from: .upcoming ) { [weak self] (result) in
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
        messageLabelView.text = "Loading Now Playing Movies..."
        NetworkManager.shared.getMovies(from: .nowPlaying ) { [weak self] (result) in
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
        messageLabelView.text = "Loading Features Movies..."
        NetworkManager.shared.getMovies(from: .topRated ) { [weak self] (result) in
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
        messageLabelView.text = "Welcome to MovieOS"
        show(createTabBar(), sender: self)
    }
    
    private func createHomeVC() -> UINavigationController{
        let homeVC = HomeVC()
        homeVC.popularMovies = popularMovies
        homeVC.upcomingMovies = upcomingMovies
        homeVC.nowPlayingMovies = nowPlayingMovies
        homeVC.featuresMovies = featuresMovies
        homeVC.title = "MovieOS"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "film"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    private func createSearchVC() -> UINavigationController{
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavoriteVC() -> UINavigationController{
        let favoriteVC = FavoritesVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)
        
        return UINavigationController(rootViewController: favoriteVC)
    }
    
    private func createTabBar() -> UITabBarController{
        let tabbar = UITabBarController()
        tabbar.viewControllers = [createHomeVC(), createSearchVC(), createFavoriteVC()]
        tabbar.modalPresentationStyle = .fullScreen
        UITabBar.appearance().tintColor = .systemPurple
        
        return tabbar
    }

}
