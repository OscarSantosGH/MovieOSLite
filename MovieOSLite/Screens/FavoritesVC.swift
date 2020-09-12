//
//  FavoritesVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    var tableView = UITableView()
    var movies:[Movie] = []
    
    let emptyScreenView = UIView()
    let heartImageView = UIImageView()
    let messageLabelView = MOTitleLabel(ofSize: 20, textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        configureEmptyScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMovies()
    }
    
    private func configureTableView(){
        tableView.frame = view.bounds
        tableView.rowHeight = 250
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(FavoriteMovieCell.self, forCellReuseIdentifier: FavoriteMovieCell.reuseID)
    }
    
    func configureEmptyScreen(){
        emptyScreenView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.image = UIImage(systemName: "heart")
        heartImageView.tintColor = .label
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabelView.text = "You don't have favorite movies yet"
    }
    
    private func getMovies(){
        let fetchRequest:NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
            if result.count > 0 {
                hideEmptyScreen()
                movies = result
                tableView.reloadData()
            }else{
                showEmptyScreen()
            }
        }else{
            showEmptyScreen()
        }
    }
    
    func showEmptyScreen(){
        tableView.removeFromSuperview()
        view.addSubview(emptyScreenView)
        emptyScreenView.pinToEdges(of: view)
        emptyScreenView.addSubviews(heartImageView, messageLabelView)
        
        NSLayoutConstraint.activate([
            heartImageView.centerXAnchor.constraint(equalTo: emptyScreenView.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: emptyScreenView.centerYAnchor, constant: -15),
            heartImageView.heightAnchor.constraint(equalToConstant: 50),
            heartImageView.widthAnchor.constraint(equalTo: heartImageView.heightAnchor),
            
            messageLabelView.topAnchor.constraint(equalTo: heartImageView.bottomAnchor, constant: 8),
            messageLabelView.leadingAnchor.constraint(equalTo: emptyScreenView.leadingAnchor, constant: 8),
            messageLabelView.trailingAnchor.constraint(equalTo: emptyScreenView.trailingAnchor, constant: -8),
            messageLabelView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func hideEmptyScreen(){
        view.addSubview(tableView)
        emptyScreenView.removeFromSuperview()
    }

}

extension FavoritesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reuseID, for: indexPath) as! FavoriteMovieCell
        if let imageData = movie.backdropImage{
            cell.set(withTitle: movie.title!, andImage: UIImage(data: imageData))
        }else{
            cell.set(withTitle: movie.title!, andImage: UIImage(named: "posterPlaceholder"))
        }
        return cell
    }
    
}

extension FavoritesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let destinationVC = MovieDetailsVC()
        guard let posterData = movie.posterImage, let posterImage = UIImage(data: posterData),
        let backdropData = movie.backdropImage, let backdropImage = UIImage(data: backdropData) else {return}
        
        destinationVC.movie = movie.getMovieDetailAPIResponse()
        destinationVC.posterImage = posterImage
        destinationVC.backdropImage = backdropImage
        destinationVC.isFavorite = true
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
