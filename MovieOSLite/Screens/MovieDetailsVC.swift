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
    @objc var shareBarButton = UIBarButtonItem()
    
    var headerImageView = MOHeaderBackdropView(frame: .zero)
    var movieInfoView = MOMovieInfoView(frame: .zero)
    var movieTrailersView = MOMovieTrailersView(frame: .zero)
    var movieCastView = MOMovieCastView(frame: .zero)
    var allViews: [UIView] = []
    
    var movie:MovieDetailAPIResponse!
    var posterImage:UIImage?
    var backdropImage:UIImage?
    
    var startScrolling = false
    var initialOffset:CGFloat = 0
    var isFavorite:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .systemPurple
        configureScrollView()
        configure()
        layoutUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfMovieIsFavorite()
        checkIfHaveVideos()
    }
    
    private func configure(){
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        if isFavorite{
            headerImageView = MOHeaderBackdropView(withImage: backdropImage!)
            movieInfoView = MOMovieInfoView(withMovie: movie, posterImage: posterImage, isFavorite: isFavorite)

        }else{
            headerImageView = MOHeaderBackdropView(withMovie: movie)
            movieInfoView = MOMovieInfoView(withMovie: movie, isFavorite: isFavorite)
        }
        
        movieTrailersView = MOMovieTrailersView(withVideos: movie.videos.results)
        movieCastView = MOMovieCastView(withMovie: movie)
        movieCastView.collectionView.delegate = self
        movieTrailersView.collectionView.delegate = self
        movieInfoView.favoriteButton.delegate = self
        shareBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMovieTrailer))
        navigationItem.rightBarButtonItem = shareBarButton
    }
    
    func configureScrollView(){
        view.addSubview(myScrollView)
        myScrollView.delegate = self
        myScrollView.addSubview(contentView)
        myScrollView.pinToEdges(of: view)
        myScrollView.showsVerticalScrollIndicator = false
        contentView.pinToEdges(of: myScrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        ])
    }
    
    private func layoutUI(){
        allViews = [movieInfoView, movieTrailersView, movieCastView]
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
            
            movieTrailersView.topAnchor.constraint(equalTo: movieInfoView.bottomAnchor),
            
            movieCastView.topAnchor.constraint(equalTo: movieTrailersView.bottomAnchor),
            movieCastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    func checkIfMovieIsFavorite() {
        let fetchRequest:NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movie.id)
        fetchRequest.predicate = predicate
        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
            if result.count == 0{
                isFavorite = false
            }else{
                isFavorite = true
            }
        }
        movieInfoView.favoriteButton.update(isFavorite: isFavorite)
    }
    
    func checkIfHaveVideos(){
        if movie.videos.results.count > 0 {
            shareBarButton.isEnabled = true
        }else{
            shareBarButton.isEnabled = false
        }
    }
    
    @objc func shareMovieTrailer(){
        let youtubeVideos = movie.videos.results.filter{$0.site.contains("YouTube")}
        print("videos: \(youtubeVideos.count)")
        let youtubeKeys = youtubeVideos.compactMap{$0.key}
        print("keys: \(youtubeKeys.count)")
        guard let trailer = URL(string: "https://youtu.be/\(youtubeKeys.first!)") else {
            shareBarButton.isEnabled = false
            return
        }
        let activityVC = UIActivityViewController(activityItems: [trailer], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }

}

// MARK: - UIScrollViewDelegate
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

// MARK: - UICollectionViewDelegate
extension MovieDetailsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == movieCastView.collectionView{
            let actor = movieCastView.cast[indexPath.row]
            checkIfPersonIsSaved(withPerson: actor.id)
        }else{
            showTrailer(withKey: movieTrailersView.videoResponses[indexPath.row].key, cell: collectionView.cellForItem(at: indexPath) as! MovieTrailerCell)
        }
    }
    
    func checkIfPersonIsSaved(withPerson id:Int){
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
            guard let person = result.first else {
                getPersonInfo(withID: id)
                return
            }
            guard let personResponse = person.getPersonResponse(),
                let profileImageData = person.profileImage,
                let profileImage = UIImage(data: profileImageData) else {return}
            presentPersonInfoVC(withPerson: personResponse, profileImage: profileImage, isSaved: true)
        }else{
            getPersonInfo(withID: id)
        }
    }
    
    private func getPersonInfo(withID personID:Int){
        showLoadingState()
        TMDBClient.shared.getPersonInfo(from: personID) { [weak self] result in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .failure(let error):
                self.presentMOAlert(title: "Error loading the cast member", message: error.localizedDescription)
                break
            case .success(let person):
                self.presentPersonInfoVC(withPerson: person, profileImage: nil, isSaved: false)
                break
            }
        }
    }
    
    private func presentPersonInfoVC(withPerson person:PersonResponse, profileImage:UIImage?, isSaved:Bool){
        let destinationVC = PersonDetailsVC()
        destinationVC.person = person
        destinationVC.delegate = self
        if isSaved{
            destinationVC.isSaved = true
            destinationVC.profileImage = profileImage
        }
        let navigationController = UINavigationController(rootViewController: destinationVC)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }
    
    private func showTrailer(withKey key: String, cell: MovieTrailerCell){
        let playerVC = MOPlayerViewController()
        let nav = UINavigationController(rootViewController: playerVC)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true) {
            playerVC.playVideoWithKey(key: key)
        }
        
    }
    
}

// MARK: - PersonDetailsVCDelegate
extension MovieDetailsVC: PersonDetailsVCDelegate{
    func updateMovieDetailsVC(withMovie movie: MovieDetailAPIResponse, posterImage: UIImage?, backdropImage: UIImage?, isFavorite: Bool) {
        self.movie = movie
        if isFavorite{
            headerImageView.update(withImage: backdropImage!)
        }else{
            headerImageView.update(withMovie: movie)
        }
        movieInfoView.update(withMovie: movie, posterImage: posterImage, isFavorite: isFavorite)
        movieTrailersView.update(withVideos: movie.videos.results)
        movieCastView.update(withMovie: movie)
        movieCastView.collectionView.reloadData()
        movieTrailersView.collectionView.reloadData()
    }
}

// MARK: - MOFavoriteButtonDelegate
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
        movieToSave.backdropImage = headerImageView.backdropImageView.image?.pngData()
        movieToSave.posterImage = movieInfoView.posterImageView.image?.pngData()
        
        do{
            try PersistenceManager.shared.viewContext.save()
        }catch{
            print("Save failed")
        }
    }
}
