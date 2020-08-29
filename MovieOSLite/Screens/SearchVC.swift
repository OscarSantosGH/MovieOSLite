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
    
    let emptyScreenView = UIView()
    let magnifyImageView = UIImageView()
    let messageLabelView = MOTitleLabel(ofSize: 20, textAlignment: .center)
    
    var movies:[MovieResponse] = []
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarController?.delegate = self
        configureSearchController()
        configureCollectionView()
        configureEmptyScreen()
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
    
    func configureEmptyScreen(){
        emptyScreenView.translatesAutoresizingMaskIntoConstraints = false
        magnifyImageView.image = UIImage(systemName: "magnifyingglass.circle")
        magnifyImageView.tintColor = .label
        magnifyImageView.contentMode = .scaleAspectFit
        magnifyImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabelView.text = "Search all the movies you want in the search bar above."
    }
    
    func showEmptyScreen(){
        collectionView.removeFromSuperview()
        view.addSubview(emptyScreenView)
        emptyScreenView.pinToEdges(of: view)
        emptyScreenView.addSubviews(magnifyImageView, messageLabelView)
        
        NSLayoutConstraint.activate([
            magnifyImageView.centerXAnchor.constraint(equalTo: emptyScreenView.centerXAnchor),
            magnifyImageView.centerYAnchor.constraint(equalTo: emptyScreenView.centerYAnchor, constant: -15),
            magnifyImageView.heightAnchor.constraint(equalToConstant: 50),
            magnifyImageView.widthAnchor.constraint(equalTo: magnifyImageView.heightAnchor),
            
            messageLabelView.topAnchor.constraint(equalTo: magnifyImageView.bottomAnchor, constant: 8),
            messageLabelView.leadingAnchor.constraint(equalTo: emptyScreenView.leadingAnchor, constant: 8),
            messageLabelView.trailingAnchor.constraint(equalTo: emptyScreenView.trailingAnchor, constant: -8),
            messageLabelView.heightAnchor.constraint(equalToConstant: 50)
        ])
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
        NetworkManager.shared.getMovie(withID: movieId) { [weak self] (result) in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .failure(let error):
                self.presentMOAlert(title: "Error loading the movie", message: error.localizedDescription)
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.presentMovieDetailsVC(withMovie: movieResponse)
                }
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
        NetworkManager.shared.searchMovies(withString: string) { [weak self] (result) in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                break
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.hideEmptyScreen()
                    self.collectionView.reloadData()
                }
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
