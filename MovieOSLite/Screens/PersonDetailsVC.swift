//
//  PersonDetailsVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

protocol PersonDetailsVCDelegate: class {
    func updateMovieDetailsVC(withMovie movie:MovieDetailAPIResponse)
}

class PersonDetailsVC: UIViewController {
    let myScrollView = UIScrollView()
    let contentView = UIView()
    
    var personInfoView = MOPersonInfoView(frame: .zero)
    var personCreditsView = MOPersonCreditsView(frame: .zero)
    var allViews: [UIView] = []
    
    var person:PersonResponse!
    
    var startScrolling = false
    var initialOffset:CGFloat = 0
    
    weak var delegate:PersonDetailsVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configure()
        layoutUI()
    }
    
//    private func getMovieCredit(){
//        let fetchRequest:NSFetchRequest<PersonMovieCredit> = PersonMovieCredit.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        let predicate = NSPredicate(format: "person == %@", person)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchRequest.predicate = predicate
//        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
//            personMovieCredits = result
//
//        }
//    }
    
    private func configure(){
        view.clipsToBounds = false
        personInfoView = MOPersonInfoView(withPerson: person)
        personCreditsView = MOPersonCreditsView(withCredits: person.movieCredits.cast)
        personCreditsView.collectionView.delegate = self
    }
    
    func configureScrollView(){
        view.addSubview(myScrollView)
        myScrollView.addSubview(contentView)
        myScrollView.pinToEdges(of: view)
        myScrollView.showsVerticalScrollIndicator = false
        contentView.pinToEdges(of: myScrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: view.frame.height)
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
            personInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150),
            
            personCreditsView.topAnchor.constraint(equalTo: personInfoView.bottomAnchor),
            personCreditsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            personCreditsView.heightAnchor.constraint(equalToConstant: 290)
        ])
        
    }
}

extension PersonDetailsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCredit = personCreditsView.personMovieCredit[indexPath.row]
        getMovieWithID(id: Int(movieCredit.id))
    }
    
    private func getMovieWithID(id:Int){
        NetworkManager.shared.getMovie(withID: id) { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print(error)
                break
            case .success(let movie):
                DispatchQueue.main.async {
                    self.delegate.updateMovieDetailsVC(withMovie: movie)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
