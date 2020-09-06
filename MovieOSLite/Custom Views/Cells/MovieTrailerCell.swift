//
//  MovieTrailerCell.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/3/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MovieTrailerCell: UICollectionViewCell {
    static let reuseID = "TrailerMovieCell"
    var trailerImage = MOTrailerImageView(frame: .zero)
    var titleLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(video: VideoResponse){
        self.titleLabel.text = video.name
        trailerImage.setImage(forURL: video.key)
    }
    
    private func configure(){
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubviews(trailerImage, titleLabel)
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            trailerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            trailerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            trailerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            trailerImage.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: trailerImage.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}