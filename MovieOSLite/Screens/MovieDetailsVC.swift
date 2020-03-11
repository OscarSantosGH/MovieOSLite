//
//  MovieDetailsVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    let headerImageView = MOBackdropImageView(frame: .zero)
    
    var movie:Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerConfig()
    }
    
    private func headerConfig(){
        view.addSubview(headerImageView)
        
        headerImageView.setImage(from: movie.backdropPath)
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

}
