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
    let ratingTextLabel = MOBodyLabel()
    var rating = "0"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie){
        titleLabel.text = movie.title
        configure(with: String(movie.voteAverage))
        guard let posterURL = movie.posterPath else {return}
        posterImageView.setPoster(from: posterURL)
    }
    
    private func configure(with rating:String){
        let padding: CGFloat = 5
        if rating == "0"{
            addSubview(posterImageView)
            addSubview(titleLabel)
            addSubview(ratingTextLabel)
            NSLayoutConstraint.activate([
                posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                posterImageView.heightAnchor.constraint(equalToConstant: 190),
                
                titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                titleLabel.heightAnchor.constraint(equalToConstant: 25),
                
                ratingTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
                ratingTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                ratingTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                ratingTextLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
            ratingTextLabel.textAlignment = .center
            ratingTextLabel.text = "Not rated"
        }else{
            addSubview(posterImageView)
            addSubview(titleLabel)
            addSubview(ratingTextLabel)
            addSubview(ratingLabel)
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
            ratingTextLabel.textAlignment = .left
            ratingTextLabel.text = "Rating: "
            ratingLabel.text = rating
        }
        
    }
}
