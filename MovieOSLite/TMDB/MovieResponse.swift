//
//  Movie.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct MovieResponse: Codable, Hashable {
    let id: Int
    var posterPath: String?
    var backdropPath: String?
    let title: String
    let originalTitle: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    var category: String?
}
