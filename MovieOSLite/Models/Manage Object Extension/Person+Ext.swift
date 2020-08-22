//
//  Person+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import CoreData

extension Person{
    func setDataFromPersonResponse(personResponse:PersonResponse){
        id = Int32(personResponse.id)
        name = personResponse.name
        birthday = personResponse.birthday
        placeOfBirth = personResponse.placeOfBirth
        profilePath = personResponse.profilePath
        biography = personResponse.biography
    }
}
