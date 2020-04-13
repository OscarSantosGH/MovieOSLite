//
//  MOHeaderBackdropView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 4/12/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOHeaderBackdropView: UIView {

    let backdropImageView = MOBackdropImageView(withCornerRadius: false)
    let blurView = UIVisualEffectView()
    let gradiantView = UIView()
    var navBarHeight:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withNavBarHeight height:CGFloat) {
        self.init(frame: .zero)
        navBarHeight = height
    }
    
    func setImage(withURLPath URLPath:String?){
        backdropImageView.setImage(from: URLPath)
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        let blurFX = UIBlurEffect(style: .systemThinMaterial)
        blurView.effect = blurFX
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        gradiantView.translatesAutoresizingMaskIntoConstraints = false
        let gradientLayer = CAGradientLayer(frame: bounds, colors: [UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.6), UIColor.clear])
        gradiantView.layer.insertSublayer(gradientLayer, at: 0)
        
        addSubviews(backdropImageView, blurView, gradiantView)
        backdropImageView.pinToEdges(of: self)
        blurView.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            gradiantView.topAnchor.constraint(equalTo: topAnchor),
            gradiantView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradiantView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradiantView.heightAnchor.constraint(equalToConstant: navBarHeight)
        ])
        
    }
}
