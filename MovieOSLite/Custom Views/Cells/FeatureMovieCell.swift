//
//  FeatureMovieCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/15/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class FeatureMovieCell: UICollectionViewCell {
    static let reuseID = "FeatureMovieCell"
    var backdropImage = MOBackdropImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie){
        backgroundColor = .blue
        guard let imagePath = movie.backdropPath else {return}
        backdropImage.setImage(from: imagePath)
    }
    
    private func configure(){
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubview(backdropImage)
        backdropImage.pinToEdges(of: self)
        backgroundColor = .blue
    }
}
