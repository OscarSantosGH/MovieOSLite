//
//  FavoritesVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var tableView = UITableView()
    var movies:[Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        getMovies()
    }
    
    private func configureTableView(){
        tableView.frame = view.bounds
        tableView.rowHeight = 250
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(FavoriteMovieCell.self, forCellReuseIdentifier: FavoriteMovieCell.reuseID)
        view.addSubview(tableView)
    }
    
    private func getMovies(){
        NetworkManager.shared.getMovies(from: .popular) { (result) in
            switch result{
            case .failure(let error):
                print(error)
                break
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            }
        }
    }

}

extension FavoritesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reuseID, for: indexPath) as! FavoriteMovieCell
        cell.set(movie: movie)
        return cell
    }
    
}

extension FavoritesVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        let destinationVC = MovieDetailsVC()
        destinationVC.movie = movie
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
