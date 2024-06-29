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
    
    static let example = PersonMovieCreditResponse(id: 693134, title: "Dune: Part Two", character: "Paul Atreides", posterPath: "/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg")
}
