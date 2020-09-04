//
//  MOPersonCreditImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOPersonCreditImageView: UIImageView {
    
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
        layer.cornerRadius = 5
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = imagePlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(forURL URLString:String?) {
        image = imagePlaceHolder
        imageURLPath = URLString
        guard let url = URLString else {return}
        TMDBClient.shared.downloadCastImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            
            if self.imageURLPath == URLString{
                self.image = image
                //self.saveImage(image: image, of: personMovieCredit)
            }
            
        }
    }
}
