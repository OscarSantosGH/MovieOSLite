//
//  SearchCategoryDetailsVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/8/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

class SearchCategoryDetailsVC: UIViewController {
    
    var collectionView:UICollectionView!
    
    var movies:[MovieResponse] = []
    
    var category:MovieCategorySearch!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        let gradientHeight:CGFloat = view.bounds.height / 3
        
        let gradient = CAGradientLayer.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: gradientHeight), colors: [category.color1, category.color2, UIColor.clear])
        gradient.zPosition = -1
        view.layer.addSublayer(gradient)
    }

}

// MARK: - UICollectionViewDataSource
extension SearchCategoryDetailsVC: UICollectionViewDataSource{
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
extension SearchCategoryDetailsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkIfMovieIsSaved(withMovie: movies[indexPath.row].id)
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
            guard let movieDetailAPIResponse = movie.getMovieDetailAPIResponse() else {return}
            presentMovieDetailsVC(withMovie: movieDetailAPIResponse, isFavorite: true)
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
                self.presentMovieDetailsVC(withMovie: movieResponse, isFavorite: false)
            }
        }
    }
    
    func presentMovieDetailsVC(withMovie movie:MovieDetailAPIResponse, isFavorite:Bool){
        let destinationVC = MovieDetailsVC()
        destinationVC.movie = movie
        destinationVC.isFavorite = isFavorite
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
