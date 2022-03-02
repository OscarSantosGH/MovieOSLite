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
    let activityView = UIActivityIndicatorView(style: .large)
    
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
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.alpha = 0
        addSubviews(trailerImage, titleLabel, activityView)
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            trailerImage.topAnchor.constraint(equalTo: topAnchor),
            trailerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            trailerImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            trailerImage.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: trailerImage.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            activityView.topAnchor.constraint(equalTo: topAnchor, constant: padding + 20),
            activityView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            activityView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    func startLoading(){
        activityView.alpha = 1
        activityView.startAnimating()
    }
    
    func stopLoading(){
        activityView.alpha = 0
        activityView.stopAnimating()
    }
}
