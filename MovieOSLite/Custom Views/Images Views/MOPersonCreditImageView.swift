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
    
    func setImage(for personMovieCredit:PersonMovieCredit) {
        image = imagePlaceHolder
        imageURLPath = personMovieCredit.posterPath
        guard let url = personMovieCredit.posterPath else {return}
        NetworkManager.shared.downloadCastImage(from: url) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.imageURLPath == personMovieCredit.posterPath{
                    self.image = image
                    self.saveImage(image: image, of: personMovieCredit)
                }
            }
        }
    }
    
    private func saveImage(image: UIImage?, of personMovieCredit:PersonMovieCredit){
        guard let imageToSave = image else {return}
        personMovieCredit.posterImage = imageToSave.pngData()
        do{
            try personMovieCredit.managedObjectContext?.save()
        }catch{
            print("save profile image failed")
        }
    }
}
