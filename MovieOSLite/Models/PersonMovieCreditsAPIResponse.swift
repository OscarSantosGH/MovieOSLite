//
//  PersonMovieCreditsAPIResponse.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct PersonMovieCreditsAPIResponse: Codable, Hashable {
    let id:Int
    let movieCredits: [PersonMovieCredits]
}
