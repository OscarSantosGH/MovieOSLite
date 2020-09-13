//
//  MOPersonProfileImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

protocol PersonProfileImageDelegate: class {
    func updateProfileImage(profileImage:UIImage)
}

class MOPersonProfileImageView: UIImageView {

    let imagePlaceHolder = UIImage(named: "placeholderCastImage")
    var imageURLPath: String?
    
    weak var delegate:PersonProfileImageDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = imagePlaceHolder
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
                self.delegate?.updateProfileImage(profileImage: unwrappedImage)
            }
            
        }
    }

}
