//
//  Actor+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import CoreData

extension Actor{
    func setDataFromActorResponse(actorResponse:ActorResponse){
        castId = Int32(actorResponse.castId)
        character = actorResponse.character
        creditId = actorResponse.creditId
        gender = Int32(actorResponse.gender ?? 0)
        id = Int32(actorResponse.id)
        name = actorResponse.name
        order = Int32(actorResponse.order)
        profilePath = actorResponse.profilePath
    }
}
