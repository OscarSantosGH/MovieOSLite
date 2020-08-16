//
//  MOPersonCreditsView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOPersonCreditsView: UIView {
    let knownForLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    var collectionView: UICollectionView!
    
    var personMovieCredit:[PersonMovieCredit] = []
    var personID: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemBackground
        knownForLabel.text = "Known For"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withPersonId id:Int) {
        self.init(frame: .zero)
        personID = id
        getCredits()
        
        configureCollectionView()
        layoutUI()
    }
    
    private func layoutUI(){
        addSubviews(knownForLabel, collectionView)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            knownForLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            knownForLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            knownForLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            knownForLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: knownForLabel.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UIHelper.createOneHorizontalLayout())
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PersonCreditsCell.self, forCellWithReuseIdentifier: PersonCreditsCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func getCredits(){
        NetworkManager.shared.getPersonInfo(from: personID) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print(error.rawValue)
                break
            case .success(let cast):
                self.personMovieCredit = cast.movieCredits.cast
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                break
            }
        }
    }
}

extension MOPersonCreditsView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personMovieCredit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCreditsCell.reuseID, for: indexPath) as! PersonCreditsCell
        cell.set(personMovieCredit: personMovieCredit[indexPath.item])
        return cell
    }
    
}
