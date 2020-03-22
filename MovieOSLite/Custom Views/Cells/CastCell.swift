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
    let actorCharacter = MORatingLabel(ofSize: 12)
    
    var actor:Actor!
    
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
    
    func set(actor: Actor){
        self.actor = actor
        actorName.text = actor.name
        actorCharacter.text = actor.character
        actorImageView.setImage(from: actor.profilePath)
    }
    
    private func configure(){
        let padding:CGFloat = 5
        
        addSubviews(actorImageView, actorName, actorCharacter)
        
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: topAnchor),
            actorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            actorImageView.widthAnchor.constraint(equalToConstant: 60),
            actorImageView.heightAnchor.constraint(equalToConstant: 80),
            
            actorName.topAnchor.constraint(equalTo: topAnchor),
            actorName.leadingAnchor.constraint(equalTo: actorImageView.trailingAnchor, constant: padding),
            actorName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            actorName.heightAnchor.constraint(equalToConstant: 20),
            
            actorCharacter.topAnchor.constraint(equalTo: actorName.bottomAnchor, constant: padding),
            actorCharacter.leadingAnchor.constraint(equalTo: actorImageView.trailingAnchor, constant: padding),
            actorCharacter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            actorCharacter.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
