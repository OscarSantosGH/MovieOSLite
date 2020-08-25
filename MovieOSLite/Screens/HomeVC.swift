//
//  HomeVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<UIHelper.Section,MovieResponse>!
    var currentSnapshot: NSDiffableDataSourceSnapshot<UIHelper.Section,MovieResponse>! = nil
    
    var popularMovies: [MovieResponse] = []
    var upcomingMovies: [MovieResponse] = []
    var nowPlayingMovies: [MovieResponse] = []
    var featuresMovies: [MovieResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        
        configureCollectionView()
        getPopularMovies()
        configureDataSource()
    }
    
    func configureCollectionView(){
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UIHelper.createHomeLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.pinToEdges(of: view)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.register(FeatureMovieCell.self, forCellWithReuseIdentifier: FeatureMovieCell.reuseID)
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UIHelper.titleElementKind, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<UIHelper.Section,MovieResponse>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            
            let section = UIHelper.Section(rawValue: indexPath.section)!
            if section == .feature{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureMovieCell.reuseID, for: indexPath) as! FeatureMovieCell
                cell.set(movie: movie)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
                cell.set(movie: movie)
                return cell
            }
            
        })
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self = self, let snapshot = self.currentSnapshot else { return nil }
            
            // Get a supplementary view of the desired kind.
            if let titleSupplementary = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleSupplementaryView.reuseIdentifier,
                for: indexPath) as? TitleSupplementaryView {

                // Populate the view with our section's description.
                let moviesCategory = snapshot.sectionIdentifiers[indexPath.section]
                titleSupplementary.label.text = moviesCategory.title

                // Return the view.
                return titleSupplementary
            } else {
                fatalError("Cannot create new supplementary")
            }
        }
    }
    
    func updateData(){
        currentSnapshot = NSDiffableDataSourceSnapshot<UIHelper.Section,MovieResponse>()
        
        UIHelper.Section.allCases.forEach {
            currentSnapshot.appendSections([$0])
        }
        
        currentSnapshot.appendItems(featuresMovies, toSection: .feature)
        currentSnapshot.appendItems(popularMovies, toSection: .popular)
        currentSnapshot.appendItems(upcomingMovies, toSection: .upcoming)
        currentSnapshot.appendItems(nowPlayingMovies, toSection: .nowPlaying)
        
        DispatchQueue.main.async {
            self.dataSource.apply(self.currentSnapshot, animatingDifferences: true)
        }
    }
    
    
    func getPopularMovies() {
        NetworkManager.shared.getMovies(from: .popular ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                print(error.rawValue)
            case .success(let movies):
                self.popularMovies = movies
                self.getUpcomingMovies()
            }
        }
    }
    
    func getUpcomingMovies() {
        NetworkManager.shared.getMovies(from: .upcoming ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                print(error.rawValue)
            case .success(let movies):
                self.upcomingMovies = movies.shuffled()
                self.getNowPlayingMovies()
            }
        }
    }
    
    func getNowPlayingMovies() {
        NetworkManager.shared.getMovies(from: .nowPlaying ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                print(error.rawValue)
            case .success(let movies):
                self.nowPlayingMovies = movies.shuffled()
                self.getFeaturesMovies()
            }
        }
    }
    
    func getFeaturesMovies(){
        NetworkManager.shared.getMovies(from: .topRated ) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                print(error.rawValue)
            case .success(let movies):
                self.featuresMovies = movies
                self.updateData()
            }
        }
    }

}

extension HomeVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else {return}
        checkIfMovieIsSaved(withMovie: movie.id)
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
            presentMovieDetailsVC(withMovie: movie.getMovieDetailAPIResponse()!, isFavorite: true)
        }else{
            getMovieDetail(ofMovie: id)
        }
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
                    self.presentMovieDetailsVC(withMovie: movieResponse, isFavorite: false)
                }
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
