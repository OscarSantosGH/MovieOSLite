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
    
    private let basePosterImgUrl = "https://image.tmdb.org/t/p/w154"
    private let baseBackdropImgUrl = "https://image.tmdb.org/t/p/w500"
    private let baseCastImgUrl = "https://image.tmdb.org/t/p/w92"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init(){
        
    }
    
    enum MoviesList: String {
        case popular = "popular"
        case upcoming = "upcoming"
        case nowPlaying = "now_playing"
    }
    
    func getMovies(from list:MoviesList, completed: @escaping (Result<[Movie], MOError>)-> Void){
        
        let endPoint = baseUrl + "\(list.rawValue)?api_key=\(API_KEY)"
        
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
                let apiResponse = try decoder.decode(MovieAPIResponse.self, from: data)
                completed(.success(apiResponse.results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func downloadPosterImage(from urlString:String, completed: @escaping (Result<UIImage,MOError>)->Void) {
        let cacheKey = NSString(string: urlString)
        let endPoint = basePosterImgUrl + urlString
        guard let url = URL(string: endPoint) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completed(.failure(.invalidData))
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(.success(image))
        }
        
        task.resume()
    }
}
