//
//  HomeVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    enum Section: CaseIterable{
        case popular
        case nowPlaying
        case upcoming
        
        var title: String{
            switch self {
            case .popular:
                return "Popular"
            case .nowPlaying:
                return "Now Playing"
            case .upcoming:
                return "Upcoming"
            }
        }
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Movie>!
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section,Movie>! = nil
    
    var popularMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []

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
        collectionView.pinToEdges(of: view)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UIHelper.titleElementKind, withReuseIdentifier: TitleSupplementaryView.reuseIdentifier)
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)
            return cell
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
        currentSnapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        
        Section.allCases.forEach {
            currentSnapshot.appendSections([$0])
        }
        
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
                self.updateData()
            }
        }
    }

}

extension HomeVC: UICollectionViewDelegate{
    
}
