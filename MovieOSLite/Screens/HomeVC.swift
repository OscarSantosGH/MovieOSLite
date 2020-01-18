//
//  HomeVC.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        
        getMovies()
    }
    
    
    func getMovies() {
        NetworkManager.shared.getPopulars { [weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print(error.rawValue)
            case .success(let movies):
                print(movies)
            }
        }
    }

}
