//
//  MOMovieCastView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

class MOMovieCastView: UIView {

    let castLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    var collectionView: UICollectionView!
    
    var cast:[ActorResponse] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withMovie movie:MovieDetailAPIResponse) {
        self.init(frame: .zero)
        getCast(ofMovie: movie)
        
        configureCollectionView()
        layoutUI()
    }
    
    func update(withMovie movie:MovieDetailAPIResponse){
        getCast(ofMovie: movie)
    }
    
    private func layoutUI(){
        addSubviews(castLabel, collectionView)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            castLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            castLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            castLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            collectionView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UIHelper.createOneHorizontalLayout(withHeight: 245))
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func getCast(ofMovie movie:MovieDetailAPIResponse){
        cast = []
        cast = movie.credits.cast
        if movie.credits.cast.count == 0{
            castLabel.text = "No Cast Found"
        }else{
            castLabel.text = "The Cast"
        }
    }
}

extension MOMovieCastView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.reuseID, for: indexPath) as! CastCell
        cell.set(actor: cast[indexPath.item])
        return cell
    }
    
}
