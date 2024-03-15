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
}
