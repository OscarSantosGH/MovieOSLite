//
//  SearchVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/18/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

class SearchVC: UIViewController {
    
    let searchController = UISearchController()
    var emptyResultsView = MOEmptySearchView(frame: .zero)
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<UIHelper.SearchSections,MovieSearchItem>!
    var currentSnapshot: NSDiffableDataSourceSnapshot<UIHelper.SearchSections,MovieSearchItem>! = nil
    
    var movies:[MovieResponse] = []
    var genres:[MovieCategorySearch] = []
    
    var currentPage:Int = 1
    var totalPages:Int = 1
    var isLoading = false
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarController?.delegate = self
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        showCategoryScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .systemPurple
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = NSLocalizedString("Search for a movie", comment: "Search for a movie")
        navigationItem.hidesSearchBarWhenScrolling = false
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
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view)
    }
    
    func showCategoryScreen(){
        genres = SearchCategories.allCategories
        movies = []
        updateData()
    }
    
    func hideCategoryScreen(){
        genres = []
        updateData()
    }
    
    func updateNavTitle(withString txt:String){
        if txt == ""{
            navigationItem.title = NSLocalizedString("Search", comment: "Search")
            currentPage = 1
            showCategoryScreen()
        }else{
            navigationItem.title = txt
            currentPage = 1
            hideCategoryScreen()
        }
    }
    
    func toggleEmptyScreen(hideView:Bool){
        if hideView{
            if emptyResultsView.isDescendant(of: view){
                emptyResultsView.removeFromSuperview()
            }
        }else{
            view.addSubview(emptyResultsView)
            emptyResultsView.pinToEdges(of: view)
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
            checkIfMovieIsSaved(withMovie: movie.id)
        }else{
            let genre = genres[indexPath.row]
            getMoviesByCategory(withCategory: genre)
        }
    }
    
    func checkIfMovieIsSaved(withMovie id:Int){
        let fetchRequest:NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
            guard let movie = result.first else {
                getMovieDetail(ofMovie: id)
                return
            }
            guard let movieDetailAPIResponse = movie.getMovieDetailAPIResponse(),
                  let posterData = movie.posterImage, let posterImage = UIImage(data: posterData),
                  let backdropData = movie.backdropImage, let backdropImage = UIImage(data: backdropData) else {return}
            
            presentMovieDetailsVC(withMovie: movieDetailAPIResponse, posterImage: posterImage, backdropImage: backdropImage, isFavorite: true)
        }else{
            getMovieDetail(ofMovie: id)
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
                self.presentMovieDetailsVC(withMovie: movieResponse , posterImage: nil, backdropImage: nil, isFavorite: false)
            }
        }
    }
    
    func presentMovieDetailsVC(withMovie movie:MovieDetailAPIResponse, posterImage:UIImage?, backdropImage:UIImage?, isFavorite:Bool){
        let destinationVC = MovieDetailsVC()
        destinationVC.movie = movie
        destinationVC.isFavorite = isFavorite
        if isFavorite{
            destinationVC.posterImage = posterImage
            destinationVC.backdropImage = backdropImage
        }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func getMoviesByCategory(withCategory category:MovieCategorySearch){
        showLoadingState()
        TMDBClient.shared.getMoviesBy(txt: category.url) { [weak self] result, categoryTotalPages in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .success(let movies):
                self.presentSearchCategoryDetailsVC(withMovies: movies, category: category, categoryTotalPages: categoryTotalPages)
            case .failure(let error):
                self.presentMOAlert(title: "Error loading the movie", message: error.localizedDescription)
            }
        }
    }
    
    func presentSearchCategoryDetailsVC(withMovies movies:[MovieResponse], category:MovieCategorySearch, categoryTotalPages:Int){
        let destinationVC = SearchCategoryDetailsVC()
        destinationVC.movies = movies
        destinationVC.totalPages = categoryTotalPages
        destinationVC.category = category
        destinationVC.title = category.title
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if movies.count != 0{
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let screenHeight = scrollView.frame.size.height
            
            if offsetY > contentHeight - screenHeight{
                guard currentPage < totalPages, !isLoading else { return }
                currentPage += 1
                searchMovies(withString: navigationItem.title!, newData: false)
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] (timer) in
            guard let self = self else {return}
            guard let text = searchController.searchBar.text, !text.isEmpty else {return}
            self.searchMovies(withString: text)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateNavTitle(withString: "")
        toggleEmptyScreen(hideView: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
    }
    
    @objc private func searchMovies(withString string:String, newData:Bool = true){
        showLoadingState()
        isLoading = true
        TMDBClient.shared.searchMovies(withString: string, page: currentPage) { [weak self] result, totalPages  in
            guard let self = self else {return}
            self.hideLoadingState()
            self.isLoading = false
            switch result{
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                break
            case .success(let movies):
                if newData{
                    self.toggleEmptyScreen(hideView: !movies.isEmpty)
                    self.movies = movies
                    self.totalPages = totalPages
                    self.updateNavTitle(withString: string)
                }else{
                    self.movies.append(contentsOf: movies)
                    self.updateData()
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

struct MovieSearchItem: Hashable {
    var movie:MovieResponse?
    var category:MovieCategorySearch?
}
