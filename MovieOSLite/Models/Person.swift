//
//  Person.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct Person: Codable, Hashable {
    let id:Int
    let name:String
    let birthday:String?
    let placeOfBirth:String?
    let profilePath:String?
    let biography:String
}
