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
    var dataSource: UICollectionViewDiffableDataSource<UIHelper.SearchSections,MovieSearchItem>!
    var currentSnapshot: NSDiffableDataSourceSnapshot<UIHelper.SearchSections,MovieSearchItem>! = nil
    
    var movies:[MovieResponse] = []
    var genres:[MovieCategorySearch] = []
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarController?.delegate = self
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        showEmptyScreen()
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a movie"
        navigationItem.searchController = searchController
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createSearchMoviesLayout())
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.register(MovieCategoryCell.self, forCellWithReuseIdentifier: MovieCategoryCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    func showEmptyScreen(){
        genres = SearchCategories.allCategories
        movies = []
        updateData()
    }
    
    func hideEmptyScreen(){
        genres = []
        updateData()
    }
    
    func updateNavTitle(withString txt:String){
        if txt == ""{
            navigationItem.title = "Search"
            showEmptyScreen()
        }else{
            navigationItem.title = txt
            hideEmptyScreen()
        }
    }
    
    // MARK: - CollectionViewDataSource
    
    func configureDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<UIHelper.SearchSections,MovieSearchItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let section = UIHelper.SearchSections(rawValue: indexPath.section)!
            if section == .searchedMovies{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
                guard let movie = item.movie else {return nil}
                cell.set(movie: movie)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCategoryCell.reuseID, for: indexPath) as! MovieCategoryCell
                guard let category = item.category else {return nil}
                cell.set(movieCategory: category)
                return cell
            }
            
        })
    }
    
    func updateData(){
        currentSnapshot = NSDiffableDataSourceSnapshot<UIHelper.SearchSections,MovieSearchItem>()
        
        UIHelper.SearchSections.allCases.forEach {
            currentSnapshot.appendSections([$0])
        }
        
        var searchedMovies:[MovieSearchItem] = []
        for movie in movies{
            let movieItem = MovieSearchItem(movie: movie, category: nil)
            searchedMovies.append(movieItem)
        }
        
        var movieGenres:[MovieSearchItem] = []
        for genre in genres{
            let genreItem = MovieSearchItem(movie: nil, category: genre)
            movieGenres.append(genreItem)
        }
        
        currentSnapshot.appendItems(searchedMovies, toSection: .searchedMovies)
        currentSnapshot.appendItems(movieGenres, toSection: .genres)
        
        DispatchQueue.main.async {
            self.dataSource.apply(self.currentSnapshot, animatingDifferences: true)
        }
    }

}


// MARK: - UICollectionViewDelegate
extension SearchVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let movie = movies[indexPath.row]
            getMovieDetail(ofMovie: movie.id)
        }else{
            let genre = genres[indexPath.row]
            getMoviesByCategory(withCategory: genre)
        }
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
    
    func getMoviesByCategory(withCategory category:MovieCategorySearch){
        showLoadingState()
        TMDBClient.shared.getMoviesBy(txt: category.url) { [weak self] (result) in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .success(let movies):
                self.presentSearchCategoryDetailsVC(withMovies: movies, category: category)
            case .failure(let error):
                self.presentMOAlert(title: "Error loading the movie", message: error.localizedDescription)
            }
        }
    }
    
    func presentSearchCategoryDetailsVC(withMovies movies:[MovieResponse], category:MovieCategorySearch){
        let destinationVC = SearchCategoryDetailsVC()
        destinationVC.movies = movies
        destinationVC.category = category
        destinationVC.title = category.title
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] (timer) in
            guard let self = self else {return}
            guard let text = searchController.searchBar.text, !text.isEmpty else {return}
            self.searchMovies(withString: text)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateNavTitle(withString: "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateNavTitle(withString: searchText)
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
                self.updateNavTitle(withString: string)
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

struct MovieSearchItem: Hashable {
    var movie:MovieResponse?
    var category:MovieCategorySearch?
}
