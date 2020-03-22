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
        guard let url = urlString else {return}
        NetworkManager.shared.downloadCastImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}