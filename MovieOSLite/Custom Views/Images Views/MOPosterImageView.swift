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
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = imagePlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(for movie:Movie) {
        image = imagePlaceHolder
        imageURLPath = movie.posterPath
        guard let url = movie.posterPath else {return}
        NetworkManager.shared.downloadPosterImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.imageURLPath == movie.posterPath{
                    self.image = image
                    self.saveImage(image: image, of: movie)
                }
            }
        }
    }
    
    private func saveImage(image: UIImage?, of movie:Movie){
        guard let imageToSave = image else {return}
        movie.posterImage = imageToSave.pngData()
        do{
            try movie.managedObjectContext?.save()
        }catch{
            print("save poster image failed")
        }
    }

}
