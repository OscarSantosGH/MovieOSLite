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
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Movie>!
    
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
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)
            return cell
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        
        Section.allCases.forEach {
            snapshot.appendSections([$0])
        }
        
        
        snapshot.appendItems(popularMovies, toSection: .popular)
        snapshot.appendItems(upcomingMovies, toSection: .upcoming)
        snapshot.appendItems(nowPlayingMovies, toSection: .nowPlaying)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
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
                self.upcomingMovies = movies
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
                self.nowPlayingMovies = movies
                self.updateData()
            }
        }
    }

}

extension HomeVC: UICollectionViewDelegate{
    
}
