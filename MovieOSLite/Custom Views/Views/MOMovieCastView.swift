//
//  MOMovieCastView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOMovieCastView: UIView {

    let castLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    var collectionView: UICollectionView!
    
    var cast:[Actor] = []
    var movieID: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemBackground
        castLabel.text = "The Cast"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withMovieId id:Int) {
        self.init(frame: .zero)
        movieID = id
        getCast()
        
        configureCollectionView()
        layoutUI()
    }
    
    private func layoutUI(){
        addSubviews(castLabel, collectionView)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            castLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            castLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            castLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: padding),
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
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func getCast(){
        NetworkManager.shared.getCast(from: movieID) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print(error.rawValue)
                break
            case .success(let cast):
                self.cast = cast
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                break
            }
        }
    }
}

extension MOMovieCastView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.reuseID, for: indexPath) as! CastCell
        cell.set(actor: cast[indexPath.item])
        return cell
    }
    
}
