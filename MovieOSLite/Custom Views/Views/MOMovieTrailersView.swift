//
//  MOMovieTrailersView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/3/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOMovieTrailersView: UIView{
    let trailersLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    var collectionView: UICollectionView!
    
    var videoResponses:[VideoResponse] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withVideos videoResponses:[VideoResponse]) {
        self.init(frame: .zero)
        self.videoResponses = videoResponses
        if videoResponses.count == 0{
            trailersLabel.text = "No Trailers Found"
        }else{
            trailersLabel.text = "Trailers"
        }
        configureCollectionView()
        layoutUI()
    }
    
    func update(withVideos videoResponses:[VideoResponse]){
        self.videoResponses = []
        self.videoResponses = videoResponses
        if videoResponses.count == 0{
            trailersLabel.text = "No Trailers Found"
        }else{
            trailersLabel.text = "Trailers"
        }
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UIHelper.createOneHorizontalLayout(withHeight: 140))
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MovieTrailerCell.self, forCellWithReuseIdentifier: MovieTrailerCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutUI(){
        addSubviews(trailersLabel, collectionView)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            trailersLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            trailersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            trailersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            trailersLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: trailersLabel.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
}

extension MOMovieTrailersView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videoResponses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTrailerCell.reuseID, for: indexPath) as! MovieTrailerCell
        cell.set(video: videoResponses[indexPath.item])
        return cell
    }
    
}
