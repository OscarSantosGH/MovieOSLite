//
//  MOPersonProfileImageView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOPersonProfileImageView: UIImageView {

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
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = imagePlaceHolder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(for person:Person) {
        image = imagePlaceHolder
        imageURLPath = person.profilePath
        guard let url = person.profilePath else {return}
        NetworkManager.shared.downloadPosterImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.imageURLPath == person.profilePath{
                    self.image = image
                    self.saveImage(image: image, of: person)
                }
            }
        }
    }
    
    private func saveImage(image: UIImage?, of person:Person){
        guard let imageToSave = image else {return}
        person.profileImage = imageToSave.pngData()
        do{
            try person.managedObjectContext?.save()
        }catch{
            print("save profile image failed")
        }
    }

}
