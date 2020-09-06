//
//  SearchVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/18/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchController = UISearchController()
    var collectionView: UICollectionView!
    
    var emptyScreenView = MOSearchCategoryView(frame: .zero)
    
    var movies:[MovieResponse] = []
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarController?.delegate = self
        configureSearchController()
        configureCollectionView()
        showEmptyScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a movie"
        navigationItem.searchController = searchController
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func showEmptyScreen(){
        collectionView.removeFromSuperview()
        view.addSubview(emptyScreenView)
        emptyScreenView.pinToEdges(of: view)
        emptyScreenView.prepare()
    }
    
    func hideEmptyScreen(){
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view)
        emptyScreenView.removeFromSuperview()
    }
    

}

// MARK: - CollectionViewDataSource
extension SearchVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.set(movie: movie)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension SearchVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        getMovieDetail(ofMovie: movie.id)
    }
    func getMovieDetail(ofMovie movieId:Int){
        showLoadingState()
        TMDBClient.shared.getMovie(withID: movieId) { [weak self] (result) in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .failure(let error):
                self.presentMOAlert(title: "Error loading the movie", message: error.localizedDescription)
            case .success(let movieResponse):
                self.presentMovieDetailsVC(withMovie: movieResponse)
            }
        }
    }
    
    func presentMovieDetailsVC(withMovie movie:MovieDetailAPIResponse){
        let destinationVC = MovieDetailsVC()
        destinationVC.movie = movie
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] (timer) in
            guard let self = self else {return}
            guard let text = searchController.searchBar.text, !text.isEmpty else {return}
            self.searchMovies(withString: text)
        }
    }
    
    
    
    @objc private func searchMovies(withString string:String){
        showLoadingState()
        TMDBClient.shared.searchMovies(withString: string) { [weak self] (result) in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                break
            case .success(let movies):
                self.movies = movies
                self.hideEmptyScreen()
                self.collectionView.reloadData()
                break
            }
        }
        
    }
}

// MARK: - UITabBarControllerDelegate
extension SearchVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.tabBar.selectedItem?.tag == 1{
            searchController.searchBar.becomeFirstResponder()
        }
    }
}
