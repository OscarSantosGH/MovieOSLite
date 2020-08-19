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
    
    private let baseUrl = "https://api.themoviedb.org/3/"
    private let API_KEY = ""
    
    private let basePosterImgUrl = "https://image.tmdb.org/t/p/w154"
    private let baseBackdropImgUrl = "https://image.tmdb.org/t/p/w500"
    private let baseCastImgUrl = "https://image.tmdb.org/t/p/w92"
    
    let cache = NSCache<NSString, UIImage>()
    
    private var searchMoviesDataTask: URLSessionDataTask?
    
    private init(){}
    
    enum MoviesList: String {
        case popular = "popular"
        case upcoming = "upcoming"
        case nowPlaying = "now_playing"
        case topRated = "top_rated"
    }
    
    func getMovies(from list:MoviesList, completed: @escaping (Result<[Movie], MOError>)-> Void){
        
        let endPoint = baseUrl + "movie/" + "\(list.rawValue)?api_key=\(API_KEY)"
        
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
                var moviesWithCategories:[Movie] = []
                for m in apiResponse.results{
                    var newMovie = m
                    newMovie.category = list.rawValue
                    moviesWithCategories.append(newMovie)
                }
                completed(.success(moviesWithCategories))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getMovie(withID id:Int, completed: @escaping (Result<Movie,MOError>)->Void){
        let endPoint = baseUrl + "movie/" + "\(String(id))?api_key=\(API_KEY)"
        
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
                let apiResponse = try decoder.decode(MovieDetailAPIResponse.self, from: data)
                let genresIds:[Int] = apiResponse.genres.compactMap{$0.id}
                let movie = Movie(id: apiResponse.id, posterPath: apiResponse.posterPath, backdropPath: apiResponse.backdropPath, title: apiResponse.title, originalTitle: apiResponse.originalTitle, voteAverage: apiResponse.voteAverage, overview: apiResponse.overview, releaseDate: apiResponse.releaseDate, genreIds: genresIds, category: "")
                completed(.success(movie))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
    
    
    func searchMovies(withString txt:String, completed: @escaping (Result<[Movie], MOError>)-> Void){
        
        let endPoint = baseUrl + "search/movie?api_key=\(API_KEY)&query=\(txt)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        searchMoviesDataTask?.cancel()
        searchMoviesDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
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
                var moviesWithCategories:[Movie] = []
                for m in apiResponse.results{
                    var newMovie = m
                    newMovie.category = "search"
                    moviesWithCategories.append(newMovie)
                }
                completed(.success(moviesWithCategories))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        searchMoviesDataTask?.resume()
    }
    
    func getCast(from movieId:Int, completed: @escaping (Result<[Actor], MOError>)-> Void){
        
        let endPoint = baseUrl + "movie/" + "\(String(movieId))/credits?api_key=\(API_KEY)"
        
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
                let apiResponse = try decoder.decode(CreditsAPIResponse.self, from: data)
                completed(.success(apiResponse.cast))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getPersonInfo(from id:Int, completed: @escaping (Result<Person, MOError>)->Void){
        let endPoint = baseUrl + "person/" + String(id) + "?api_key=\(API_KEY)" + "&append_to_response=movie_credits"
        //print("MY URL: \(endPoint)")
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
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
                let apiResponse = try decoder.decode(Person.self, from: data)
                completed(.success(apiResponse))
            }catch{
                completed(.failure(.invalidData))
                //print("error decoding: \(error)")
            }
        }
        
        task.resume()
    }
    
    
    func downloadPosterImage(from urlString:String, completed: @escaping (UIImage?)->Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        let endPoint = basePosterImgUrl + urlString
        guard let url = URL(string: endPoint) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    func downloadBackdropImage(from urlString:String, completed: @escaping (UIImage?)->Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        let endPoint = baseBackdropImgUrl + urlString
        guard let url = URL(string: endPoint) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    func downloadCastImage(from urlString:String, completed: @escaping (UIImage?)->Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        let endPoint = baseCastImgUrl + urlString
        guard let url = URL(string: endPoint) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
