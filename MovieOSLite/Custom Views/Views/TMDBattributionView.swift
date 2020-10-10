//
//  TMDBattributionView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 10/9/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class TMDBattributionView: UIView {
    
    let titleLabel = MOTitleLabel(ofSize: 20, textAlignment: .center)
    let logoImageView = UIImageView(image: UIImage(named: "tmdb-logo"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = NSLocalizedString("Powered by", comment: "attribute TMDb as the source")
        
        addSubviews(titleLabel, logoImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            logoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
