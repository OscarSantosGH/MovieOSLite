//
//  MOMovieInfoView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOMovieInfoView: UIView {

    let posterImageView = MOPosterImageView(frame: .zero)
    let titleLabel = MOTitleLabel(ofSize: 25, textAlignment: .left)
    var ratingLabel = MOHighlightInfoView(frame: .zero)
    var releaseDateLabel = MOHighlightInfoView(frame: .zero)
    var genresStackView = MOGenresTagStackView(frame: .zero)
    let storylineLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    let storylineBodyLabel = MOBodyLabel(alignment: .left)
    
    var movie:Movie!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(withMovie movie:Movie){
        self.init(frame: .zero)
        self.movie = movie
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        posterImageView.setImage(from: movie.posterPath)
        titleLabel.text = movie.title
        ratingLabel = MOHighlightInfoView(info: String(movie.voteAverage), desc: "Ratings")
        configureReleaseDate()
        genresStackView = MOGenresTagStackView(withGenres: movie.genreIds)
        storylineLabel.text = "Overview"
        storylineBodyLabel.text = movie.overview
    }
    
    private func configureReleaseDate(){
        releaseDateLabel = MOHighlightInfoView(info: movie.releaseDate, desc: "Release Date")
    }
    
    private func layoutUI(){
        addSubviews(posterImageView,
                    titleLabel,
                    ratingLabel,
                    releaseDateLabel,
                    genresStackView,
                    storylineLabel,
                    storylineBodyLabel
        )
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: -50),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: 111),
            posterImageView.heightAnchor.constraint(equalToConstant: 152),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 45),

            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            ratingLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            ratingLabel.widthAnchor.constraint(equalToConstant: 60),
            ratingLabel.heightAnchor.constraint(equalToConstant: 44),

            releaseDateLabel.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: padding),
            releaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            releaseDateLabel.heightAnchor.constraint(equalTo: ratingLabel.heightAnchor),

            genresStackView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: padding),
            genresStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            genresStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),

            storylineLabel.topAnchor.constraint(equalTo: genresStackView.bottomAnchor, constant: 40),
            storylineLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            storylineLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            storylineLabel.heightAnchor.constraint(equalToConstant: 20),

            storylineBodyLabel.topAnchor.constraint(equalTo: storylineLabel.bottomAnchor, constant: padding),
            storylineBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            storylineBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            storylineBodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}