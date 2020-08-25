//
//  FeatureMovieCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/15/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class FeatureMovieCell: UICollectionViewCell {
    static let reuseID = "FeatureMovieCell"
    var backdropImage = MOBackdropImageView(frame: .zero)
    var titleLabel = MOTitleLabel(ofSize: 15, textAlignment: .left, textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: MovieResponse){
        self.titleLabel.text = movie.title
        backdropImage.setImage(forURL: movie.backdropPath)
    }
    
    private func configure(){
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubviews(backdropImage, titleLabel)
        backdropImage.pinToEdges(of: self)
        
        let layer = CAGradientLayer()
        let color1 = UIColor.rgb(red: 10, green: 10, blue: 10, alpha: 0.9)
        let color2 = UIColor.rgb(red: 10, green: 10, blue: 10, alpha: 0)
        layer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 95)
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        layer.colors = [color1.cgColor, color2.cgColor]
        backdropImage.layer.addSublayer(layer)
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
