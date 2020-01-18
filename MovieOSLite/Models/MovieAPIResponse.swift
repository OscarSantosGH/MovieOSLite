//
//  MovieAPIResponse.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct MovieAPIResponse: Codable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
}
