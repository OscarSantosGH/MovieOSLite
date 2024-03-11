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
    
    static let example = MovieResponse(id: 1234, posterPath: "8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg", backdropPath: "9Le7N3fmrHnWwdxCg35jSSawFyK.jpg", title: "Dune: Part Two", originalTitle: "Dune 2", voteAverage: 84.2, overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.", releaseDate: "03/01/2024", genreIds: [878, 12])
}
