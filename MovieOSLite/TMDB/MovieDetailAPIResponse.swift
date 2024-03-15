//
//  MovieDetailAPIResponse.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct MovieDetailAPIResponse: Codable, Hashable {
    let id: Int
    var posterPath: String?
    var backdropPath: String?
    let title: String
    let originalTitle: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let genres: [GenreResponse]
    let credits: CreditsAPIResponse
    var videos: VideosAPIResponse
    
    static let example = MovieDetailAPIResponse(id: 693134, posterPath: "/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg", backdropPath: "/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg", title: "Dune: Part Two", originalTitle: "Dune: Part Two", voteAverage: 8.428, overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.", releaseDate: "2024-02-27", genres: [GenreResponse(id: 878, name: "Science Fiction"), GenreResponse(id: 12, name: "Adventure")], credits: CreditsAPIResponse(cast: [ActorResponse.example]), videos: VideosAPIResponse(results: [VideoResponse.example]))
}
