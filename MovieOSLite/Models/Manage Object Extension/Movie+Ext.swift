//
//  Movie+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import CoreData

extension Movie{
    func setDataFromMovieResponse(movieResponse:MovieResponse) {
        id = Int32(movieResponse.id)
        posterPath = movieResponse.posterPath
        backdropPath = movieResponse.backdropPath
        title = movieResponse.title
        originalTitle = movieResponse.originalTitle
        voteAverage = movieResponse.voteAverage
        overview = movieResponse.overview
        releaseDate = movieResponse.releaseDate
        genreIds = movieResponse.genreIds.compactMap{Int32($0)}
    }
}
