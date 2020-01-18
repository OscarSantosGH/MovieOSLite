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
    let titleLabel = MOTitleLabel(of: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie){
        titleLabel.text = movie.title
    }
    
    private func configure(){
        addSubview(posterImageView)
        addSubview(titleLabel)
        let padding: CGFloat = 5
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
