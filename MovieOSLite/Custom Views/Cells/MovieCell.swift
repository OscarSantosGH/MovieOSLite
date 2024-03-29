//
//  MovieCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/18/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseID = "MovieCell"
    let posterImageView = MOPosterImageView(frame: .zero)
    let titleLabel = MOTitleLabel(ofSize: 14, textAlignment: .center)
    let ratingLabel = MORatingLabel(ofSize: 11, textAlignment: .right)
    let ratingTextLabel = MOTitleLabel(ofSize:12, textAlignment: .left, textColor: .secondaryLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        layer.cornerRadius = 10
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: MovieResponse){
        titleLabel.text = movie.title
        posterImageView.image = nil
        posterImageView.setImage(forURL: movie.posterPath)
        if movie.voteAverage == 0.0{
            ratingTextLabel.text = NSLocalizedString("Not Rated", comment: "When the movie isn't rated")
            ratingLabel.alpha = 0
        }else{
            ratingTextLabel.text = NSLocalizedString("Rating: ", comment: "Rating: ")
            ratingLabel.alpha = 1
        }
        ratingLabel.text = String(movie.voteAverage)
    }
    
    private func configure(){
        let padding: CGFloat = 5
        addSubviews(posterImageView, titleLabel, ratingLabel, ratingTextLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 190),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20),
            ratingLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 25),
            
            ratingTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            ratingTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            ratingTextLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -padding),
            ratingTextLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        ratingTextLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        ratingTextLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        ratingLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        ratingLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
