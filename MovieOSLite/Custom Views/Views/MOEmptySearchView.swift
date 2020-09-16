//
//  MOEmptySearchView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/15/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOEmptySearchView: UIView {
    
    var iconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass.circle"))
    var titleLabel = MOTitleLabel(ofSize: 25, textAlignment: .center)
    var subTitleLabel = MOTitleLabel(ofSize: 15, textAlignment: .center, textColor: .secondaryLabel)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = .label
        iconImageView.contentMode = .scaleAspectFit
        titleLabel.text = "No movies found"
        subTitleLabel.text = "Try searching again using a different spelling or keyword."
        
        addSubviews(iconImageView, titleLabel, subTitleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
}
