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
    var actors: [Actor]
    var creditsResponse: CreditsAPIResponse
    var genreResponse: [GenreResponse]
    var videosResponse: VideosAPIResponse
    @Relationship(deleteRule: .cascade) var genres: [Genre]
    @Relationship(deleteRule: .cascade) var videos: [Video]
    
    init(id: Int, posterPath: String?, posterImage: Data?, backdropPath: String?, backdropImage: Data?, title: String, originalTitle: String, voteAverage: Float, overview: String, releaseDate: String, actors: [Actor], creditsResponse: CreditsAPIResponse, genreResponse: [GenreResponse], videosResponse: VideosAPIResponse, genres: [Genre], videos: [Video]) {
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
        self.creditsResponse = creditsResponse
        self.genreResponse = genreResponse
        self.videosResponse = videosResponse
        self.actors = actors
        self.genres = genres
        self.videos = videos
    }
    
    convenience init(from movieDetail: MovieDetailAPIResponse, posterImage: Data?, backdropImage: Data?, videos: [Video], actors: [Actor]) {
        let genres = movieDetail.genres.map { Genre(from: $0) }
        self.init(id: movieDetail.id,
                  posterPath: movieDetail.posterPath,
                  posterImage: posterImage,
                  backdropPath: movieDetail.backdropPath,
                  backdropImage: backdropImage,
                  title: movieDetail.title,
                  originalTitle: movieDetail.originalTitle,
                  voteAverage: movieDetail.voteAverage,
                  overview: movieDetail.overview,
                  releaseDate: movieDetail.releaseDate,
                  actors: actors,
                  creditsResponse: movieDetail.credits,
                  genreResponse: movieDetail.genres,
                  videosResponse: movieDetail.videos,
                  genres: genres,
                  videos: videos)
    }
}
