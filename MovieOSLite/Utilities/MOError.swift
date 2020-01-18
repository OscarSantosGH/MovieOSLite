//
//  MOError.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

enum MOError: String, Error {
    case invalidURL = "The URL is invalid. The server could be in maintenance"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidMovieArray = "Unable to get a collection of movies"
}
