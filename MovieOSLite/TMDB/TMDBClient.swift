//
//  TMDBClient.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/4/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class TMDBClient{
    static let shared = TMDBClient()
    
    private let baseUrl = "https://api.themoviedb.org/3/"
    private let API_KEY = ""
    
    private let basePosterImgUrl = "https://image.tmdb.org/t/p/w154"
    private let baseBackdropImgUrl = "https://image.tmdb.org/t/p/w500"
    private let baseCastImgUrl = "https://image.tmdb.org/t/p/w92"
    private let baseYoutubeThumbUrl = "https://img.youtube.com/vi/"
    
    private init(){}
    
    enum MoviesList: String {
        case popular = "popular"
        case upcoming = "upcoming"
        case nowPlaying = "now_playing"
        case topRated = "top_rated"
    }
    
    func getMovies(from list:MoviesList, completed: @escaping (Result<[MovieResponse], MOError>)-> Void){
        
        let endPoint = baseUrl + "movie/" + "\(list.rawValue)?api_key=\(API_KEY)"
        
        guard let url = URL(string: endPoint) else {
            DispatchQueue.main.async {
                completed(.failure(.invalidURL))
            }
            return
        }
        
        NetworkManager.shared.getMovies(withURL: url, movieCategory: list.rawValue) { result, totalPages in
            switch result{
            case .success(let movies):
                completed(.success(movies))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func getMovie(withID id:Int, completed: @escaping (Result<MovieDetailAPIResponse,MOError>)->Void){
        let endPoint = baseUrl + "movie/" + "\(String(id))?api_key=\(API_KEY)" + "&append_to_response=credits,videos"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        NetworkManager.shared.getMovie(withURL: url) { (result) in
            switch result{
            case .success(let movie):
                completed(.success(movie))
            case .failure(let error):
                completed(.failure(error))
            }
        }
        
    }
    
    
    func searchMovies(withString txt:String, page:Int = 1, completed: @escaping (Result<[MovieResponse], MOError>, _ totalPages:Int)-> Void){
        let secureTxt = txt.replacingOccurrences(of: " ", with: "%20")
        let endPoint = baseUrl + "search/movie?api_key=\(API_KEY)&query=\(secureTxt)&page=" + String(page)
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL), 0)
            return
        }
        
        NetworkManager.shared.searchMovies(withURL: url) { result ,totalPages  in
            switch result{
            case .success(let movie):
                completed(.success(movie), totalPages)
            case .failure(let error):
                completed(.failure(error), 0)
            }
        }
    }
    
    func getMoviesBy(txt:String, page:Int = 1, completed: @escaping (Result<[MovieResponse], MOError>, _ totalPages:Int)->Void){
        let endPoint = baseUrl + "discover/movie?api_key=\(API_KEY)&page=" + String(page) + txt
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL), 0)
            return
        }
        
        NetworkManager.shared.getMovies(withURL: url, movieCategory: txt) { result, totalPages in
            switch result{
            case .success(let movies):
                completed(.success(movies), totalPages)
            case .failure(let error):
                completed(.failure(error), 0)
            }
        }
    }
    
    func getPersonInfo(from id:Int, completed: @escaping (Result<PersonResponse, MOError>)->Void){
        let endPoint = baseUrl + "person/" + String(id) + "?api_key=\(API_KEY)" + "&append_to_response=movie_credits"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        NetworkManager.shared.getPersonInfo(withURL: url) { (result) in
            switch result{
            case .success(let person):
                completed(.success(person))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    
    func downloadPosterImage(from urlString:String, completed: @escaping (UIImage?)->Void) {
        
        let endPoint = basePosterImgUrl + urlString
        guard let url = URL(string: endPoint) else {
            completed(nil)
            return
        }
        
        NetworkManager.shared.downloadImage(withURL: url) { (image) in
            completed(image)
        }
    }
    
    func downloadBackdropImage(from urlString:String, completed: @escaping (UIImage?)->Void) {
        
        let endPoint = baseBackdropImgUrl + urlString
        guard let url = URL(string: endPoint) else {
            completed(nil)
            return
        }
        
        NetworkManager.shared.downloadImage(withURL: url) { (image) in
            completed(image)
        }
    }
    
    func downloadCastImage(from urlString:String, completed: @escaping (UIImage?)->Void) {
        
        let endPoint = baseCastImgUrl + urlString
        guard let url = URL(string: endPoint) else {
            completed(nil)
            return
        }
        
        NetworkManager.shared.downloadImage(withURL: url) { (image) in
            completed(image)
        }
    }
    
    func downloadTrailerImage(from urlString:String, completed: @escaping (UIImage?)->Void) {
        
        let endPoint = baseYoutubeThumbUrl + urlString + "/0.jpg"
        guard let url = URL(string: endPoint) else {
            DispatchQueue.main.async {
                completed(nil)
            }
            return
        }
        
        NetworkManager.shared.downloadImage(withURL: url) { (image) in
            completed(image)
        }
    }
}
