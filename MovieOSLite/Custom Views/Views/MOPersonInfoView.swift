//
//  MOPersonInfoView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOPersonInfoView: UIView {
    let posterImageView = MOPosterImageView(frame: .zero)
    let nameLabel = MOTitleLabel(ofSize: 25, textAlignment: .left)
    var birthdayLabel = MOHighlightInfoView(frame: .zero)
    var placeOfBirthLabel = MOHighlightInfoView(frame: .zero)
    let biographyLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    let biographyBodyLabel = MOBodyLabel(alignment: .left)
    
    var person:Person!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withPerson person:Person){
        self.init(frame: .zero)
        self.person = person
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemBackground
        posterImageView.setImage(from: person.profilePath)
        nameLabel.text = person.name
        birthdayLabel = MOHighlightInfoView(info: String(person.birthday ?? "Unknown"), desc: "Age")
        configureReleaseDate()
        biographyLabel.text = "Biography"
        biographyBodyLabel.text = person.biography
    }
    
    private func configureReleaseDate(){
        placeOfBirthLabel = MOHighlightInfoView(info: person.placeOfBirth ?? "Unknown", desc: "Place Of Birth")
    }
    
    private func layoutUI(){
        addSubviews(posterImageView,
                    nameLabel,
                    birthdayLabel,
                    placeOfBirthLabel,
                    biographyLabel,
                    biographyBodyLabel
        )
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: -50),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: 111),
            posterImageView.heightAnchor.constraint(equalToConstant: 152),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 45),

            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            birthdayLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            birthdayLabel.widthAnchor.constraint(equalToConstant: 60),
            birthdayLabel.heightAnchor.constraint(equalToConstant: 44),

            placeOfBirthLabel.topAnchor.constraint(equalTo: birthdayLabel.topAnchor),
            placeOfBirthLabel.leadingAnchor.constraint(equalTo: birthdayLabel.trailingAnchor, constant: padding),
            placeOfBirthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            placeOfBirthLabel.heightAnchor.constraint(equalTo: birthdayLabel.heightAnchor),

            biographyLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 35),
            biographyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            biographyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            biographyLabel.heightAnchor.constraint(equalToConstant: 20),

            biographyBodyLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: padding),
            biographyBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            biographyBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            biographyBodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            biographyBodyLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 150)
        ])
    }
}