//
//  PersonMovieCredits.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct PersonMovieCreditResponse: Codable, Hashable {
    let id:Int
    let title:String
    let character:String
    let posterPath:String?
}
