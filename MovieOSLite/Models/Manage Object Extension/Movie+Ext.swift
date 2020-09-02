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
    
    func getMovieResponse() -> MovieResponse{
        MovieResponse(id: Int(id), posterPath: posterPath, backdropPath: backdropPath, title: title!, originalTitle: originalTitle!, voteAverage: voteAverage, overview: overview!, releaseDate: releaseDate!, genreIds: (genres?.compactMap{Int($0.id)})!, category: nil)
    }
    
    func getMovieDetailAPIResponse() -> MovieDetailAPIResponse?{
        var actorsResponse:[ActorResponse] = []
        var videosResponse:[VideoResponse] = []
        guard let unwrappedActors = actors else {return nil}
        for (_, actorR) in unwrappedActors.enumerated(){
            guard let actorModel = actorR as? Actor else {return nil}
            actorsResponse.append(actorModel.getActorResponse())
        }
        
        guard let unwrappedVideos = videos else {return nil}
        for (_, videoR) in unwrappedVideos.enumerated(){
            guard let videoModel = videoR as? Video else {return nil}
            videosResponse.append(videoModel.getVideoResponse())
        }
        
        let creditsResponse = CreditsAPIResponse(cast: actorsResponse)
        let videosAPIResponse = VideosAPIResponse(results: videosResponse)
        
        return MovieDetailAPIResponse(id: Int(id), posterPath: posterPath, backdropPath: backdropPath, title: title!, originalTitle: originalTitle!, voteAverage: voteAverage, overview: overview!, releaseDate: releaseDate!, genres: (genres?.compactMap{GenreResponse(id: Int($0.id), name: String($0.name))})!, credits: creditsResponse, videos: videosAPIResponse)
    }
}
