//
//  Cast.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct ActorResponse: Codable, Hashable {
    let castId: Int
    let character: String
    let creditId: String
    var gender: Int?
    let id: Int
    let name: String
    let order: Int
    var profilePath: String?
    
    static let example = ActorResponse(castId: 2, character: "Paul Atreides", creditId: "5e959c45955c6500159f1c98", gender: 2, id: 1190668, name: "Timothée Chalamet", order: 0, profilePath: "/BE2sdjpgsa2rNTFa66f7upkaOP.jpg")
}
