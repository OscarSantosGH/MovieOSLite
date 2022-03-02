//
//  FavoriteMovieCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/19/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {
    
    static let reuseID = "FavoriteMovieCell"
    let containerView = UIView()
    let blurView = UIVisualEffectView()
    let backdropImageView = MOBackdropImageView(withCornerRadius: false)
    var titleLabel = MOTitleLabel(ofSize: 20, textAlignment: .left, textColor: .white)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(withTitle title:String, andImage image:UIImage?){
        backdropImageView.image = image
        titleLabel.text = title
    }
    
    private func configure(){
        clipsToBounds = true
        selectionStyle = .none
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        let blurFX = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurView.effect = blurFX
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.pinToEdgesWithSafeArea(of: self, withPadding: 8)
        
        containerView.addSubviews(backdropImageView, blurView, titleLabel)
        backdropImageView.pinToEdges(of: containerView)
        
        NSLayoutConstraint.activate([
            blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurView.heightAnchor.constraint(equalToConstant: 55),
            
            titleLabel.topAnchor.constraint(equalTo: blurView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: 8)
        ])
    }

}
