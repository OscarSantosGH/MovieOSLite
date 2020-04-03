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
    
    private func configure(){
        layer.cornerRadius = 5
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = imagePlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(from urlString:String?) {
        image = imagePlaceHolder
        imageURLPath = urlString
        guard let url = urlString else {return}
        NetworkManager.shared.downloadBackdropImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.imageURLPath == urlString{
                    self.image = image
                }
            }
        }
    }

}
