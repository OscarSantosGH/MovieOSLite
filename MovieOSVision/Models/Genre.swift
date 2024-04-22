//
//  Genre.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/22/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import Foundation
import SwiftData

@Model
class Genre {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    convenience init(from genreResponse: GenreResponse) {
        self.init(id: genreResponse.id, name: genreResponse.name)
    }
}
