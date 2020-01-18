//
//  Movie.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    var posterPath: String?
    var backdropPath: String?
    let title: String?
    let originalTitle: String?
    var voteAverage: Float?
    var overview: String?
    var releaseDate: String?
    var genreIds: [Int]?
}
