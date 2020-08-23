//
//  Movie+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import CoreData

extension Movie{
    
    //@NSManaged public var genres: [Genre]
    
    func setDataFromMovieResponse(movieResponse:MovieResponse) {
        id = Int32(movieResponse.id)
        posterPath = movieResponse.posterPath
        backdropPath = movieResponse.backdropPath
        title = movieResponse.title
        originalTitle = movieResponse.originalTitle
        voteAverage = movieResponse.voteAverage
        overview = movieResponse.overview
        releaseDate = movieResponse.releaseDate
        genres = movieResponse.genreIds.compactMap{Genre(id: $0, name: TMDBGenres.genresDic[$0] ?? "unknown")}
    }
    
    func setDataFromMovieResponse(movieResponse:MovieDetailAPIResponse) {
        id = Int32(movieResponse.id)
        posterPath = movieResponse.posterPath
        backdropPath = movieResponse.backdropPath
        title = movieResponse.title
        originalTitle = movieResponse.originalTitle
        voteAverage = movieResponse.voteAverage
        overview = movieResponse.overview
        releaseDate = movieResponse.releaseDate
        genres = movieResponse.genres.compactMap{Genre(id: $0.id, name: $0.name)}
    }
}
