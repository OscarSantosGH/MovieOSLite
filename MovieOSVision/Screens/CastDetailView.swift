//
//  CastDetailView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 6/28/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct CastDetailView: View {
    var actor: PersonResponse
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    MOImageLoaderView(imagePath: actor.profilePath, imageType: .cast)
                    .frame(width: 200, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .padding(.bottom)
                    
                    VStack {
                        Text(actor.name)
                            .font(.extraLargeTitle)
                            .padding()
                        
                        HStack {
                            VStack(alignment: .center) {
                                Text(age)
                                    .font(.title)
                                Text("Age")
                                    .font(.title2)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(actor.placeOfBirth ?? "Unknown")
                                    .font(.title)
                                Text("Place Of Birth")
                                    .font(.title2)
                            }
                        }
                    }
                }
                
                Text("Biography")
                    .font(.title)
                    .padding(.top)
                
                Text(bio)
                    .font(.body)
                    .padding(.vertical)
                
            }
        }
    }
    
    private var age: String {
        guard let stringDateFromTMDB = actor.birthday else { return "??" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:stringDateFromTMDB) else { return "??" }
        
        let form = DateComponentsFormatter()
        form.maximumUnitCount = 3
        form.unitsStyle = .full
        form.allowedUnits = [.year]
        let s = form.string(from: date, to: Date())
        
        var age = ""
        
        for c in s!{
            if c == " "{
                break
            }else{
                age.append(c)
            }
        }
        
        return age
    }
    
    private var bio: String {
        actor.biography == "" ? "No Biography Found" : actor.biography
    }
}

#Preview {
    CastDetailView(actor: PersonResponse.example)
}
