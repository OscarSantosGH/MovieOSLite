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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withMovie movie:MovieDetailAPIResponse) {
        self.init(frame: .zero)
        backdropImageView.setImage(forURL: movie.backdropPath)
    }
    
    convenience init(withImage image:UIImage){
        self.init(frame: .zero)
        backdropImageView.image = image
    }
    
    func update(withMovie movie:MovieDetailAPIResponse){
        backdropImageView.setImage(forURL: movie.backdropPath)
    }
    
    func update(withImage image:UIImage){
        backdropImageView.image = image
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        let blurFX = UIBlurEffect(style: .systemThinMaterial)
        blurView.effect = blurFX
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(backdropImageView, blurView)
        backdropImageView.pinToEdges(of: self)
        blurView.pinToEdges(of: self)
        blurView.alpha = 0
    }
    
    func animateBlur(value:CGFloat){
        let positiveVal = value < 0 ? 0 : value
        blurView.alpha = positiveVal
    }
}
