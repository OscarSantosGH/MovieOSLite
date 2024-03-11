//
//  NetworkManager.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit
import Network

class NetworkManager{
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    private let monitor = NWPathMonitor()
    private var searchMoviesDataTask: URLSessionDataTask?
    var isInternetAvailable = false
    
    private init(){}
    
    func checkForInternetConnection(){
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else {return}
            if path.status == .satisfied {
                self.isInternetAvailable = true
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NotificationNames.internetAvailable, object: nil)
                }
            } else {
                self.isInternetAvailable = false
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NotificationNames.internetNotAvailable, object: nil)
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func getMovies(withURL url:URL, movieCategory category:String, completed: @escaping (Result<[MovieResponse], MOError>, _ totalPages:Int)-> Void){
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                DispatchQueue.main.async {
                    completed(.failure(.unableToComplete), 0)
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidResponse), 0)
                }
                return
            }
            
            guard let data = data else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidData), 0)
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(MoviesAPIResponse.self, from: data)
                var moviesWithCategories:[MovieResponse] = []
                for m in apiResponse.results{
                    var newMovie = m
                    newMovie.category = category
                    moviesWithCategories.append(newMovie)
                }
                DispatchQueue.main.async {
                    completed(.success(moviesWithCategories), apiResponse.totalPages)
                }
            } catch {
                DispatchQueue.main.async {
                    completed(.failure(.invalidData), 0)
                }
            }
        }
        
        task.resume()
    }
    
    func getMovies(withURL url:URL, movieCategory category:String) async -> (Result<[MovieResponse], MOError>, Int) {
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                return (.failure(.invalidResponse), 0)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let apiResponse = try decoder.decode(MoviesAPIResponse.self, from: data)
            var moviesWithCategories:[MovieResponse] = []
            for m in apiResponse.results{
                var newMovie = m
                newMovie.category = category
                moviesWithCategories.append(newMovie)
            }
            return (.success(moviesWithCategories), apiResponse.totalPages)
            
        } catch {
            return (.failure(.invalidData), 0)
        }
    }
    
    func getMovie(withURL url:URL, completed: @escaping (Result<MovieDetailAPIResponse,MOError>)->Void){
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                DispatchQueue.main.async {
                    completed(.failure(.unableToComplete))
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidData))
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(MovieDetailAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(apiResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completed(.failure(.invalidData))
                }
            }
        }
        
        task.resume()
        
    }
    
    func getTrailers(withURL url:URL, completed: @escaping (Result<VideosAPIResponse,MOError>)->Void){
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                DispatchQueue.main.async {
                    completed(.failure(.unableToComplete))
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidData))
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(VideosAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(apiResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completed(.failure(.invalidData))
                }
            }
        }
        
        task.resume()
        
    }
    
    
    func searchMovies(withURL url:URL, completed: @escaping (Result<[MovieResponse], MOError>, _ totalPages:Int)-> Void){
        
        searchMoviesDataTask?.cancel()
        searchMoviesDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                DispatchQueue.main.async {
                    completed(.failure(.unableToComplete), 0)
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidResponse), 0)
                }
                return
            }
            
            guard let data = data else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidData), 0)
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(MoviesAPIResponse.self, from: data)
                var moviesWithCategories:[MovieResponse] = []
                for m in apiResponse.results{
                    var newMovie = m
                    newMovie.category = "search"
                    moviesWithCategories.append(newMovie)
                }
                DispatchQueue.main.async {
                    completed(.success(moviesWithCategories), apiResponse.totalPages)
                }
            } catch {
                DispatchQueue.main.async {
                    completed(.failure(.invalidData), 0)
                }
            }
        }
        
        searchMoviesDataTask?.resume()
    }
    
    func getPersonInfo(withURL url:URL, completed: @escaping (Result<PersonResponse, MOError>)->Void){
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let _ = error{
                DispatchQueue.main.async {
                    completed(.failure(.unableToComplete))
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else{
                DispatchQueue.main.async {
                    completed(.failure(.invalidData))
                }
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try decoder.decode(PersonResponse.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(apiResponse))
                }
            }catch{
                DispatchQueue.main.async {
                    completed(.failure(.invalidData))
                }
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(withURL url:URL, completed: @escaping (UIImage?)->Void) {
        
        let urlString = url.absoluteString
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completed(nil)
                    }
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }
    
    func downloadImage(withURL url: URL) async -> UIImage? {
        let urlString = url.absoluteString
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey){
            return image
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let image = UIImage(data: data) else{
                return nil
            }
            
            cache.setObject(image, forKey: cacheKey)
            return image
            
        } catch {
            return nil
        }
    }
    
}
