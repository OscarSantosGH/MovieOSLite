//
//  MovieDetailsVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerImageView = MOBackdropImageView(frame: .zero)
    var movieInfoView = MOMovieInfoView(frame: .zero)
    var movieCastView = MOMovieCastView(frame: .zero)
    var allViews: [UIView] = []
    
    var movie:Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
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
        movieCastView = MOMovieCastView(withMovieId: movie.id)
        movieCastView.collectionView.delegate = self
        movieCastView.setNeedsFocusUpdate()
    }
    
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        scrollView.showsVerticalScrollIndicator = false
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor)
            //contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 950)
        ])
    }
    
    private func layoutUI(){
        allViews = [headerImageView, movieInfoView, movieCastView]
        
        for v in allViews{
            contentView.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            movieInfoView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor),
            //movieInfoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 350),
            
            movieCastView.topAnchor.constraint(equalTo: movieInfoView.bottomAnchor),
            movieCastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            movieCastView.heightAnchor.constraint(equalToConstant: 290)
            
        ])
        
    }
    
    private func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}

extension MovieDetailsVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension MovieDetailsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let actor = movieCastView.cast[indexPath.row]
        
    }
    
}
