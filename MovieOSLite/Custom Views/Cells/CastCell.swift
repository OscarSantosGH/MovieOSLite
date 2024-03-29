//
//  CastCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class CastCell: UICollectionViewCell {
    static let reuseID = "CastCell"
    let actorImageView = MOCastImageView(frame: .zero)
    let actorName = MOTitleLabel(ofSize: 12, textAlignment: .center)
    let actorCharacter = MOTitleLabel(ofSize: 12, textAlignment: .center, textColor: .systemOrange)
    
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
    
    func set(actor: ActorResponse){
        actorImageView.image = nil
        actorName.text = actor.name
        actorCharacter.text = actor.character
        actorImageView.setImage(forURL: actor.profilePath)
    }
    
    private func configure(){
        let padding:CGFloat = 5
        
        addSubviews(actorImageView, actorName, actorCharacter)
        
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: topAnchor),
            actorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            actorImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            actorImageView.heightAnchor.constraint(equalToConstant: 190),
            
            actorName.topAnchor.constraint(equalTo: actorImageView.bottomAnchor),
            actorName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            actorName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            actorName.heightAnchor.constraint(equalToConstant: 25),
            
            actorCharacter.topAnchor.constraint(equalTo: actorName.bottomAnchor),
            actorCharacter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            actorCharacter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            actorCharacter.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
