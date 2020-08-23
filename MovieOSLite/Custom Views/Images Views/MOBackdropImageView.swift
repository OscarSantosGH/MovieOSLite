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
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = imagePlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(for movie:Movie) {
        image = imagePlaceHolder
        imageURLPath = movie.backdropPath
        guard let url = movie.backdropPath else {return}
        NetworkManager.shared.downloadBackdropImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.imageURLPath == movie.backdropPath{
                    self.image = image
                    self.saveImage(image: image, of: movie)
                }
            }
        }
    }
    
    private func saveImage(image: UIImage?, of movie:Movie){
        guard let imageToSave = image else {return}
        movie.backdropImage = imageToSave.pngData()
        do{
            try movie.managedObjectContext?.save()
        }catch{
            print("save backdrop image failed")
        }
    }

}
