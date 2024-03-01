//
//  PersonDetailsVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

protocol PersonDetailsVCDelegate: AnyObject {
    func updateMovieDetailsVC(withMovie movie:MovieDetailAPIResponse, posterImage:UIImage?, backdropImage:UIImage?, isFavorite:Bool)
}

class PersonDetailsVC: UIViewController {
    let myScrollView = UIScrollView()
    let contentView = UIView()
    
    var personInfoView = MOPersonInfoView(frame: .zero)
    var personCreditsView = MOPersonCreditsView(frame: .zero)
    var allViews: [UIView] = []
    
    var person:PersonResponse!
    var profileImage:UIImage?
    var isSaved = false
    
    var startScrolling = false
    var initialOffset:CGFloat = 0
    
    weak var delegate:PersonDetailsVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configure()
        layoutUI()
    }
    
    private func configure(){
        view.clipsToBounds = false
        
        if isSaved{
            personInfoView = MOPersonInfoView(withPerson: person, profileImage: profileImage, isSaved: isSaved, profileImageDelegate: self)
        }else{
            personInfoView = MOPersonInfoView(withPerson: person, profileImage: nil, isSaved: isSaved, profileImageDelegate: self)
        }
        
        personCreditsView = MOPersonCreditsView(withCredits: person.movieCredits.cast)
        personCreditsView.collectionView.delegate = self
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView(){
        view.addSubview(myScrollView)
        myScrollView.addSubview(contentView)
        myScrollView.pinToEdges(of: view)
        myScrollView.showsVerticalScrollIndicator = false
        myScrollView.backgroundColor = .systemBackground
        contentView.pinToEdges(of: myScrollView)
        
        let contentHeightConstraint = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        contentHeightConstraint.priority = UILayoutPriority(rawValue: 25)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor),
            contentHeightConstraint
        ])
    }
    
    private func layoutUI(){
        allViews = [personInfoView, personCreditsView]
        
        for v in allViews{
            contentView.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            personInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            
            personCreditsView.topAnchor.constraint(equalTo: personInfoView.bottomAnchor),
            personCreditsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            personCreditsView.heightAnchor.constraint(equalToConstant: 290)
        ])
        
    }
    
    private func savePerson(){
        let personToSave = Person(context: PersistenceManager.shared.viewContext)
        personToSave.setDataFromPersonResponse(personResponse: person)
        personToSave.profileImage = profileImage?.pngData()
        
        do{
            try PersistenceManager.shared.viewContext.save()
        }catch{
            print("Save failed")
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

// MARK: - PersonProfileImageDelegate
extension PersonDetailsVC: PersonProfileImageDelegate{
    func updateProfileImage(profileImage: UIImage) {
        self.profileImage = profileImage
        savePerson()
    }
}

// MARK: - UICollectionViewDelegate
extension PersonDetailsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCredit = personCreditsView.personMovieCredit[indexPath.row]
        checkIfMovieIsSaved(withMovie: Int(movieCredit.id))
    }
    
    func checkIfMovieIsSaved(withMovie id:Int){
        let fetchRequest:NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
            guard let movie = result.first else {
                getMovieWithID(id: id)
                return
            }
            guard let movieDetailAPIResponse = movie.getMovieDetailAPIResponse(),
                  let posterData = movie.posterImage, let posterImage = UIImage(data: posterData),
                  let backdropData = movie.backdropImage, let backdropImage = UIImage(data: backdropData) else {return}
            
            delegate.updateMovieDetailsVC(withMovie: movieDetailAPIResponse, posterImage: posterImage, backdropImage: backdropImage, isFavorite: true)
            dismiss(animated: true, completion: nil)
        }else{
            getMovieWithID(id: id)
        }
    }
    
    private func getMovieWithID(id:Int){
        showLoadingState()
        TMDBClient.shared.getMovie(withID: id) { [weak self] (result) in
            guard let self = self else {return}
            self.hideLoadingState()
            switch result{
            case .failure(let error):
                print(error)
                break
            case .success(let movie):
                self.delegate.updateMovieDetailsVC(withMovie: movie, posterImage: nil, backdropImage: nil, isFavorite: false)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
