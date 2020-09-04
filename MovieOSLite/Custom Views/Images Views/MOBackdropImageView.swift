//
//  MOBackdropImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/15/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOBackdropImageView: UIImageView {

    let imagePlaceHolder = UIImage(named: "posterPlaceholder")
    var imageURLPath: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withCornerRadius withCorner:Bool = true){
        self.init(frame: .zero)
        if withCorner{
            layer.cornerRadius = 5
        }
    }
    
    private func configure(){
        image = imagePlaceHolder
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(forURL URLString:String?) {
        image = imagePlaceHolder
        imageURLPath = URLString
        guard let url = URLString else {return}
        TMDBClient.shared.downloadBackdropImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            
            if self.imageURLPath == URLString{
                self.image = image
                //self.saveImage(image: image, of: movie)
            }
            
        }
    }

}
