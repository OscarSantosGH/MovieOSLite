//
//  HomeVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Movie>!
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        
        configureCollectionView()
        getMovies()
        configureDataSource()
    }
    
    func configureCollectionView(){
        
        let width = view.bounds.width
        let padding: CGFloat = 1
        let minimunItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimunItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 245)
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
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
    
    func updateData(on movies:[Movie]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    func getMovies() {
        NetworkManager.shared.getMovies(from: .upcoming) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .failure(let error):
                print(error.rawValue)
            case .success(let movies):
                self.movies = movies
                self.updateData(on: self.movies)
            }
        }
    }

}

extension HomeVC: UICollectionViewDelegate{
    
}
