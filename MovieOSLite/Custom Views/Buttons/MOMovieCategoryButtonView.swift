//
//  MOMovieCategoryButtonView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/5/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOMovieCategoryButtonView: UIView {
    let titleLabel = MOTitleLabel(ofSize: 25, textAlignment: .left, textColor: .white)
    let iconImageView = UIImageView()
    var gradientColor1 = UIColor()
    var gradientColor2 = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title:String, color1:UIColor, color2:UIColor, image:UIImage){
        self.init(frame: .zero)
        titleLabel.text = title
        gradientColor1 = color1
        gradientColor2 = color2
        iconImageView.image = image
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        addSubviews(titleLabel, iconImageView)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        
    }
    
    func activateGradient(){
        let gradient = CAGradientLayer.init(frame: bounds, colors: [gradientColor1, gradientColor2])
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
    
}
