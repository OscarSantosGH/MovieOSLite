//
//  SearchVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/18/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        //searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a movie"
        //searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
