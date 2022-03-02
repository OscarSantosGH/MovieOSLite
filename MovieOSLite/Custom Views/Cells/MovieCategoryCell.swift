//
//  MovieCategoryCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/7/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MovieCategoryCell: UICollectionViewCell {
    static let reuseID = "MovieCategoryCell"
    let titleLabel = MOTitleLabel(ofSize: 25, textAlignment: .left, textColor: .white)
    let iconImageView = UIImageView()
    var url:String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movieCategory:MovieCategorySearch){
        titleLabel.text = movieCategory.title
        iconImageView.image = movieCategory.image
        self.url = movieCategory.url
        
        let gradient = CAGradientLayer.init(frame: bounds, colors: [movieCategory.color1, movieCategory.color2])
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
    
    private func configure(){
        clipsToBounds = true
        layer.cornerRadius = 10
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        addSubviews(titleLabel, iconImageView)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
}
