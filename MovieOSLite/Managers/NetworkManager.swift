//
//  NetworkManager.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let API_KEY = ""
    
    private let baseImgUrl = "https://image.tmdb.org/t/p/w154"
    private let baseBackdropImgUrl = "https://image.tmdb.org/t/p/w500"
    private let baseCastImgUrl = "https://image.tmdb.org/t/p/w92"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init(){
        
    }
    
    func getPopulars(completed: @escaping (Result<[Movie], MOError>)-> Void){
        
        let endPoint = baseUrl + "popular?api_key=\(API_KEY)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode([Movie].self, from: data)
                completed(.success(movies))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
