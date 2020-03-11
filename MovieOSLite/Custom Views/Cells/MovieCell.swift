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
    let titleLabel = MOTitleLabel(ofSize: 12, textAlignment: .center)
    let ratingLabel = MORatingLabel(ofSize: 13)
    let ratingTextLabel = MOTitleLabel(ofSize:15, textAlignment: .left, textColor: .secondaryLabel)
    
    var movieID:Int!
    
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
    
    func set(movie: Movie){
        titleLabel.text = movie.title
        movieID = movie.id
        if movie.voteAverage == 0.0{
            ratingTextLabel.text = "Not rated"
            ratingLabel.alpha = 0
        }else{
            ratingTextLabel.text = "Rating: "
            ratingLabel.alpha = 1
        }
        ratingLabel.text = String(movie.voteAverage)
        posterImageView.setImage(from: movie.posterPath)
    }
    
    private func configure(){
        let padding: CGFloat = 5
        addSubviews(posterImageView, titleLabel, ratingLabel, ratingTextLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            posterImageView.heightAnchor.constraint(equalToConstant: 190),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ratingLabel.heightAnchor.constraint(equalToConstant: 25),
            ratingLabel.widthAnchor.constraint(equalToConstant: 25),
            
            ratingTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            ratingTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            ratingTextLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -padding),
            ratingTextLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
