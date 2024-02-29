//
//  MOFavoriteButtonImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

protocol MOFavoriteButtonDelegate: AnyObject {
    func saveMovieToFavorites()
    func deleteMovieFromFavorite()
}

class MOFavoriteButtonImageView: UIImageView {

    var tapGesture: UITapGestureRecognizer!
    var delegate:MOFavoriteButtonDelegate?
    var isFavorite = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(isFavorite:Bool) {
        self.init(frame: .zero)
        update(isFavorite: isFavorite)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(isFavorite:Bool) {
        self.isFavorite = isFavorite
        if isFavorite{
            image = UIImage(systemName: "heart.fill")
        }else{
            image = UIImage(systemName: "heart")
        }
    }
    
    private func configure(){
        image = UIImage(systemName: "heart")
        tintColor = .systemPink
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        
        addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTapped(){
        isFavorite = !isFavorite
        if isFavorite{
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self = self else {return}
                self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.image = UIImage(systemName: "heart.fill")
            }) { [weak self] (complete) in
                guard let self = self else {return}
                UIView.animate(withDuration: 0.3) {
                    self.transform = CGAffineTransform.identity
                }
            }
            delegate?.saveMovieToFavorites()
        }else{
            image = UIImage(systemName: "heart")
            delegate?.deleteMovieFromFavorite()
        }
        
    }
    
}
