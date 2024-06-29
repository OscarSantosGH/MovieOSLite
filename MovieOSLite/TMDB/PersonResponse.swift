//
//  Person.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct PersonResponse: Codable, Hashable {
    let id:Int
    let name:String
    let birthday:String?
    let placeOfBirth:String?
    let profilePath:String?
    let biography:String
    let movieCredits: PersonMovieCredits
    
    static let example = PersonResponse(id: 1190668, name: "Timothée Chalamet", birthday: "1995-12-27", placeOfBirth: "Manhattan, New York City, New York, USA", profilePath: "/BE2sdjpgsa2rNTFa66f7upkaOP.jpg", biography: "Timothée Hal Chalamet (born December 27, 1995) is an American actor. \n\nHe began his career appearing in the drama series Homeland in 2012. Two years later, he made his film debut in the comedy-drama Men, Women & Children and appeared in Christopher Nolan's science fiction film Interstellar. He came into attention in Luca Guadagnino's coming-of-age film Call Me by Your Name (2017). Alongside supporting roles in Greta Gerwig's films Lady Bird (2017) and Little Women (2019), he took on starring roles in Beautiful Boy (2018) and Dune (2021).", movieCredits: PersonMovieCredits(cast: [PersonMovieCreditResponse.example]))
}
