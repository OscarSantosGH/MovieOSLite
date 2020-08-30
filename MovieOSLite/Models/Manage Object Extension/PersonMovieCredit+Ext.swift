//
//  PersonMovieCredit+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import CoreData

extension PersonMovieCredit{
    func setDataFromPersonMovieCreditResponse(personMovieCreditResponse:PersonMovieCreditResponse){
        id = Int32(personMovieCreditResponse.id)
        title = personMovieCreditResponse.title
        character = personMovieCreditResponse.character
        posterPath = personMovieCreditResponse.posterPath
    }
    
    func getPersonMovieCreditResponse() -> PersonMovieCreditResponse{
        PersonMovieCreditResponse(id: Int(id), title: title!, character: character!, posterPath: posterPath)
    }
}
