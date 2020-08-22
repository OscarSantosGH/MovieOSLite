//
//  Cast.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct Actor: Codable, Hashable {
    let castId: Int
    let character: String
    let creditId: String
    var gender: Int?
    let id: Int
    let name: String
    var profilePath: String?
}
