//
//  Movie.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/21/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import Foundation
import SwiftData

@Model
class Movie {
    var id: Int
    var posterPath: String?
    var posterImage: Data?
    var backdropPath: String?
    var backdropImage: Data?
    var title: String
    var originalTitle: String
    var voteAverage: Float
    var overview: String
    var releaseDate: String
    
    init(id: Int, posterPath: String?, posterImage: Data?, backdropPath: String?, backdropImage: Data?, title: String, originalTitle: String, voteAverage: Float, overview: String, releaseDate: String) {
        self.id = id
        self.posterPath = posterPath
        self.posterImage = posterImage
        self.backdropPath = backdropPath
        self.backdropImage = backdropImage
        self.title = title
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    convenience init(from movieDetail: MovieDetailAPIResponse, posterImage: Data?, backdropImage: Data?) {
        self.init(id: movieDetail.id,
                  posterPath: movieDetail.posterPath,
                  posterImage: posterImage,
                  backdropPath: movieDetail.backdropPath,
                  backdropImage: backdropImage,
                  title: movieDetail.title,
                  originalTitle: movieDetail.originalTitle,
                  voteAverage: movieDetail.voteAverage,
                  overview: movieDetail.overview,
                  releaseDate: movieDetail.releaseDate)
    }
}
