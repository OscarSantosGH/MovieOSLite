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
    var movieInfoView = MOMovieInfoView(frame: .zero)
    
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
        navbarConfigure()
        configure()
        layoutUI()
    }
    
    private func navbarConfigure(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func configure(){
        headerImageView.setImage(from: movie.backdropPath)
        movieInfoView = MOMovieInfoView(withMovie: movie)
    }
    
    private func layoutUI(){
        view.addSubviews(headerImageView, movieInfoView)
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            movieInfoView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            movieInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //movieInfoView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        movieInfoView.genresStackView.layoutGenresLabels()
    }

}
