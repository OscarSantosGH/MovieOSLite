//
//  MOTabBarController.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOTabBarController: UITabBarController {
    
    var popularMovies: [MovieResponse] = []
    var upcomingMovies: [MovieResponse] = []
    var nowPlayingMovies: [MovieResponse] = []
    var featuresMovies: [MovieResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        UITabBar.appearance().tintColor = .systemPurple
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(popularMovies: [MovieResponse], upcomingMovies: [MovieResponse], nowPlayingMovies: [MovieResponse], featuresMovies: [MovieResponse]) {
        super.init(nibName: nil, bundle: nil)
        self.popularMovies = popularMovies
        self.upcomingMovies = upcomingMovies
        self.nowPlayingMovies = nowPlayingMovies
        self.featuresMovies = featuresMovies
        viewControllers = [createHomeVC(), createSearchVC(), createFavoriteVC()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        let searchNavController = UINavigationController(rootViewController: searchVC)
        searchNavController.navigationBar.prefersLargeTitles = true
        return searchNavController
    }
    
    private func createFavoriteVC() -> UINavigationController{
        let favoriteVC = FavoritesVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)
        
        return UINavigationController(rootViewController: favoriteVC)
    }

}