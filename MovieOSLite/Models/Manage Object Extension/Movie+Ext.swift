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
        
        for genreId in movieResponse.genreIds{
            let genreResponse = GenreResponse(id: genreId, name: TMDBGenres.genresDic[genreId] ?? "unknown")
            let genreToSave = Genre(context: PersistenceManager.shared.viewContext)
            genreToSave.setDataFromGenreResponse(genreResponse: genreResponse)
            addToGenres(genreToSave)
        }
        
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
        
        for genre in movieResponse.genres{
            let genreToSave = Genre(context: PersistenceManager.shared.viewContext)
            genreToSave.setDataFromGenreResponse(genreResponse: genre)
            addToGenres(genreToSave)
        }
        
        for actor in movieResponse.credits.cast{
            let actorToSave = Actor(context: PersistenceManager.shared.viewContext)
            actorToSave.setDataFromActorResponse(actorResponse: actor)
            addToActors(actorToSave)
        }
        
        for video in movieResponse.videos.results{
            let videoToSave = Video(context: PersistenceManager.shared.viewContext)
            videoToSave.setDataFromVideoResponse(videoResponse: video)
            addToVideos(videoToSave)
        }
        
    }
    
    func getMovieResponse() -> MovieResponse?{
        var genresResponse:[GenreResponse] = []
        guard let unwrappedGenres = genres else {return nil}
        for (_, genreR) in unwrappedGenres.enumerated(){
            guard let genreModel = genreR as? Genre else {return nil}
            genresResponse.append(genreModel.getGenreResponse())
        }
        return MovieResponse(id: Int(id), posterPath: posterPath, backdropPath: backdropPath, title: title!, originalTitle: originalTitle!, voteAverage: voteAverage, overview: overview!, releaseDate: releaseDate!, genreIds: genresResponse.compactMap{$0.id}, category: nil)
    }
    
    func getMovieDetailAPIResponse() -> MovieDetailAPIResponse?{
        var actorsResponse:[ActorResponse] = []
        var videosResponse:[VideoResponse] = []
        var genresResponse:[GenreResponse] = []
        
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
        
        guard let unwrappedGenres = genres else {return nil}
        for (_, genreR) in unwrappedGenres.enumerated(){
            guard let genreModel = genreR as? Genre else {return nil}
            genresResponse.append(genreModel.getGenreResponse())
        }
        
        let creditsResponse = CreditsAPIResponse(cast: actorsResponse)
        let videosAPIResponse = VideosAPIResponse(results: videosResponse)
        
        return MovieDetailAPIResponse(id: Int(id), posterPath: posterPath, backdropPath: backdropPath, title: title!, originalTitle: originalTitle!, voteAverage: voteAverage, overview: overview!, releaseDate: releaseDate!, genres: genresResponse, credits: creditsResponse, videos: videosAPIResponse)
    }
}
