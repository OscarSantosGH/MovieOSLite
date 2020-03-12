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
    
    init(movie:Movie){
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        headerConfig()
    }
    
    private func headerConfig(){
        view.addSubview(headerImageView)
        
        headerImageView.setImage(from: movie.backdropPath)
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

}
