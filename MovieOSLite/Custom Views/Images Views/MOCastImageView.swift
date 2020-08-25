//
//  MOCastImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOCastImageView: UIImageView {

    let imagePlaceHolder = UIImage(named: "placeholderCastImage")
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
        NetworkManager.shared.downloadCastImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.imageURLPath == URLString{
                    self.image = image
                    //self.saveImage(image: image, of: actor)
                }
            }
        }
    }

}
