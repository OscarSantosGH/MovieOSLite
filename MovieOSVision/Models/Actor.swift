//
//  Actor.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/22/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import Foundation
import SwiftData

@Model
class Actor {
    var castId: Int
    var character: String
    var creditId: String
    var gender: Int?
    var id: Int
    var name: String
    var order: Int
    var profilePath: String?
    
    init(castId: Int, character: String, creditId: String, gender: Int? = nil, id: Int, name: String, order: Int, profilePath: String? = nil) {
        self.castId = castId
        self.character = character
        self.creditId = creditId
        self.gender = gender
        self.id = id
        self.name = name
        self.order = order
        self.profilePath = profilePath
    }
    
    convenience init(from actorResponse: ActorResponse) {
        self.init(castId: actorResponse.castId,
                  character: actorResponse.character,
                  creditId: actorResponse.creditId,
                  gender: actorResponse.gender,
                  id: actorResponse.id,
                  name: actorResponse.name,
                  order: actorResponse.order,
                  profilePath: actorResponse.profilePath)
    }
}
