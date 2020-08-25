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
    var movies:[MovieDetailAPIResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        view.addSubview(tableView)
    }
    
    private func getMovies(){
        let fetchRequest:NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let result = try? PersistenceManager.shared.viewContext.fetch(fetchRequest){
            movies = result.compactMap{$0.getMovieDetailAPIResponse()}
            tableView.reloadData()
        }
    }

}

extension FavoritesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let movieResponse = MovieResponse(id: movie.id, posterPath: movie.posterPath, backdropPath: movie.backdropPath, title: movie.title, originalTitle: movie.originalTitle, voteAverage: movie.voteAverage, overview: movie.overview, releaseDate: movie.releaseDate, genreIds: movie.genres.compactMap{$0.id}, category: "")
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reuseID, for: indexPath) as! FavoriteMovieCell
        cell.set(movie: movieResponse)
        return cell
    }
    
}

extension FavoritesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let destinationVC = MovieDetailsVC()
        destinationVC.movie = movie
        destinationVC.isFavorite = true
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
