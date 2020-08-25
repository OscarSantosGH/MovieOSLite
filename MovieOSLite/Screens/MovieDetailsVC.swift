//
//  MovieDetailsVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailsVC: UIViewController {
    
    let myScrollView = UIScrollView()
    let contentView = UIView()
    
    var headerImageView = MOHeaderBackdropView(frame: .zero)
    var movieInfoView = MOMovieInfoView(frame: .zero)
    var movieCastView = MOMovieCastView(frame: .zero)
    var allViews: [UIView] = []
    
    var movie:MovieDetailAPIResponse!
    
    var startScrolling = false
    var initialOffset:CGFloat = 0
    var isFavorite:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configure()
        layoutUI()
    }
    
    
    private func configure(){
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        headerImageView = MOHeaderBackdropView(withMovie: movie)
        movieInfoView = MOMovieInfoView(withMovie: movie, isFavorite: isFavorite)
        movieCastView = MOMovieCastView(withMovie: movie)
        movieCastView.collectionView.delegate = self
        movieInfoView.favoriteButton.delegate = self
    }
    
    func configureScrollView(){
        view.addSubview(myScrollView)
        myScrollView.delegate = self
        myScrollView.addSubview(contentView)
        myScrollView.pinToEdges(of: view)
        myScrollView.showsVerticalScrollIndicator = false
        contentView.pinToEdges(of: myScrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor)
        ])
    }
    
    private func layoutUI(){
        allViews = [movieInfoView, movieCastView]
        view.addSubview(headerImageView)
        headerImageView.layer.zPosition = 0
        myScrollView.layer.zPosition = 1
        
        for v in allViews{
            contentView.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -100),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 200),
            
            movieInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 200),
            
            movieCastView.topAnchor.constraint(equalTo: movieInfoView.bottomAnchor),
            movieCastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            movieCastView.heightAnchor.constraint(equalToConstant: 290)
            
        ])
        
    }

}

extension MovieDetailsVC:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !startScrolling{
            initialOffset = scrollView.contentOffset.y
            startScrolling = true
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if startScrolling{
            var headerTransform = CATransform3DIdentity
            let offset = scrollView.contentOffset.y
            
            let headerScaleFactor:CGFloat = -(offset - (initialOffset)) / headerImageView.bounds.height

            if offset < initialOffset {
                headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
                headerImageView.layer.transform = headerTransform
            }else{
                headerTransform = CATransform3DTranslate(headerTransform, 0, -(offset - (initialOffset)), 0)
                headerImageView.layer.transform = headerTransform
            }
            let diff:CGFloat = -(offset - (initialOffset)) * 0.007
            headerImageView.animateBlur(value: diff)
        }
        
    }
}

extension MovieDetailsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actor = movieCastView.cast[indexPath.row]
        getPersonInfo(withID: Int(actor.id))
    }
    
    private func getPersonInfo(withID personID:Int){
        NetworkManager.shared.getPersonInfo(from: personID) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print(error.rawValue)
                break
            case .success(let person):
                DispatchQueue.main.async {
                    self.presentPersonInfoVC(withPerson: person)
                }
                break
            }
        }
    }
    
    private func presentPersonInfoVC(withPerson person:PersonResponse){
        let destinationVC = PersonDetailsVC()
        destinationVC.person = person
        destinationVC.delegate = self
        let navigationController = UINavigationController(rootViewController: destinationVC)
        navigationController.navigationBar.isHidden = true
        present(navigationController, animated: true)
    }
    
}

extension MovieDetailsVC: PersonDetailsVCDelegate{
    func updateMovieDetailsVC(withMovie movie: MovieDetailAPIResponse) {
        self.movie = movie
        headerImageView.update(withMovie: movie)
        movieInfoView.update(withMovie: movie, isFavorite: isFavorite)
        movieCastView.update(withMovie: movie)
    }
}

extension MovieDetailsVC: MOFavoriteButtonDelegate{
    func deleteMovieFromFavorite() {
        let fetchRequest:NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movie.id)
        fetchRequest.predicate = predicate
        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
            guard let movie = result.first else {return}
            PersistenceManager.shared.viewContext.delete(movie)
            PersistenceManager.shared.saveOrRollback()
        }
    }
    
    func saveMovieToFavorites(){
        let movieToSave = Movie(context: PersistenceManager.shared.viewContext)
        movieToSave.setDataFromMovieResponse(movieResponse: movie)
        
        for actor in movie.credits.cast{
            let actorToSave = Actor(context: PersistenceManager.shared.viewContext)
            actorToSave.setDataFromActorResponse(actorResponse: actor)
            movieToSave.addToActors(actorToSave)
        }
        
        do{
            try PersistenceManager.shared.viewContext.save()
        }catch{
            print("Save failed")
        }
    }
}
