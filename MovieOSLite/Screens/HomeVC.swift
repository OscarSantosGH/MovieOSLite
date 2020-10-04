//
//  HomeVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData
import AVKit

class HomeVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<UIHelper.MainSections,MovieResponse>!
    var currentSnapshot: NSDiffableDataSourceSnapshot<UIHelper.MainSections,MovieResponse>! = nil
    
    var popularMovies: [MovieResponse] = []
    var upcomingMovies: [MovieResponse] = []
    var nowPlayingMovies: [MovieResponse] = []
    var featuresMovies: [MovieResponse] = []
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        updateData()
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScrollFeatureMovies), userInfo: nil, repeats: false)
        
        MOPlayerViewController.shared.playerVC.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
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
        dataSource = UICollectionViewDiffableDataSource<UIHelper.MainSections,MovieResponse>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            
            let section = UIHelper.MainSections(rawValue: indexPath.section)!
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
        currentSnapshot = NSDiffableDataSourceSnapshot<UIHelper.MainSections,MovieResponse>()
        
        UIHelper.MainSections.allCases.forEach {
            currentSnapshot.appendSections([$0])
        }
        
        currentSnapshot.appendItems(featuresMovies, toSection: .feature)
        currentSnapshot.appendItems(popularMovies, toSection: .popular)
        currentSnapshot.appendItems(upcomingMovies, toSection: .upcoming)
        currentSnapshot.appendItems(nowPlayingMovies, toSection: .nowPlaying)
        
        DispatchQueue.main.async {
            self.dataSource.apply(self.currentSnapshot, animatingDifferences: true)
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    @objc private func autoScrollFeatureMovies(){
        collectionView.scrollToItem(at: IndexPath(row: 2, section: 0), at: .centeredHorizontally, animated: true)
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
                self.presentMovieDetailsVC(withMovie: movieResponse, posterImage: nil, backdropImage: nil, isFavorite: false)
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
}

//MARK: - AVPlayerViewControllerDelegate
extension HomeVC: AVPlayerViewControllerDelegate{
    
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
            
            let currentviewController = navigationController?.visibleViewController
            
            if currentviewController != playerViewController{
                currentviewController?.present(playerViewController, animated: true, completion: nil)
            }
            completionHandler(true)
        
    }
    
}
