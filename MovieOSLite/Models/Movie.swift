//
//  Movie.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable {
    let identifier: UUID = UUID()
    
    let id: Int
    var posterPath: String?
    var backdropPath: String?
    let title: String
    let originalTitle: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
