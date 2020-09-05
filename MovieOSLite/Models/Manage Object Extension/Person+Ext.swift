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
        
        for movieCredit in personResponse.movieCredits.cast{
            let personMovieCredit = PersonMovieCredit(context: PersistenceManager.shared.viewContext)
            personMovieCredit.setDataFromPersonMovieCreditResponse(personMovieCreditResponse: movieCredit)
            addToMovieCredits(personMovieCredit)
        }
        
    }
    
    func getPersonResponse() -> PersonResponse?{
        var personMovieCreditResponses:[PersonMovieCreditResponse] = []
        
        guard let unwrappedCredit = movieCredits else {return nil}
        
        for (_, credit) in unwrappedCredit.enumerated(){
            guard let creditModel = credit as? PersonMovieCredit else {return nil}
            personMovieCreditResponses.append(creditModel.getPersonMovieCreditResponse())
        }
        
        let personMovieCredits = PersonMovieCredits(cast: personMovieCreditResponses)
        
        return PersonResponse(id: Int(id), name: name!, birthday: birthday, placeOfBirth: placeOfBirth, profilePath: profilePath, biography: biography!, movieCredits: personMovieCredits)
    }
}
