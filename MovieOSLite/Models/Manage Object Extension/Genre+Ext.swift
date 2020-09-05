//
//  Genre+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/5/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import CoreData

extension Genre {
    func setDataFromGenreResponse(genreResponse: GenreResponse){
        id = Int32(genreResponse.id)
        name = genreResponse.name
    }
    
    func getGenreResponse() -> GenreResponse{
        GenreResponse(id: Int(id), name: name!)
    }
}
