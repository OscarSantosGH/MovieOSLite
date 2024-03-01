//
//  MOPosterImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOPosterImageView: UIImageView {
    
    let imagePlaceHolder = UIImage(named: "posterPlaceholder")
    var imageURLPath: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        image = imagePlaceHolder
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(forURL URLString:String?) {
        image = imagePlaceHolder
        imageURLPath = URLString
        guard let url = URLString else {return}
        TMDBClient.shared.downloadPosterImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            
            if self.imageURLPath == URLString{
                guard let unwrappedImage = image else {return}
                self.image = unwrappedImage
            }
            
        }
    }

}
