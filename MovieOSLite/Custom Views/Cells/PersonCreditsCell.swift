//
//  PersonCreditsCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class PersonCreditsCell: UICollectionViewCell {
    static let reuseID = "PersonCreditCell"
    let movieImageView = MOCastImageView(frame: .zero)
    let movieName = MOTitleLabel(ofSize: 12, textAlignment: .center)
    let actorCharacter = MOTitleLabel(ofSize: 12, textAlignment: .center, textColor: .systemOrange)
    
    //var personMovieCredit:PersonMovieCredit!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        layer.cornerRadius = 5
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(personMovieCredit: PersonMovieCredit){
        //self.personMovieCredit = personMovieCredit
        movieImageView.image = nil
        movieName.text = personMovieCredit.title
        actorCharacter.text = personMovieCredit.character
        movieImageView.setImage(from: personMovieCredit.posterPath)
    }
    
    private func configure(){
        let padding:CGFloat = 5
        
        addSubviews(movieImageView, movieName, actorCharacter)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 190),
            
            movieName.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            movieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieName.heightAnchor.constraint(equalToConstant: 25),
            
            actorCharacter.topAnchor.constraint(equalTo: movieName.bottomAnchor),
            actorCharacter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            actorCharacter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            actorCharacter.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
