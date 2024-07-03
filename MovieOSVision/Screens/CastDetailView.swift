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
                HStack(alignment: .top) {
                    MOImageLoaderView(imagePath: actor.profilePath, imageType: .cast)
                    .frame(width: 200, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text(actor.name)
                            .font(.extraLargeTitle)
                            .padding([.leading, .bottom])
                        
                        Group {
                            //TODO: Create localization for "Birthday"
                            Text("Birthday")
                                .font(.title2)
                            Text(age)
                                .font(.title)
                                .padding(.bottom)
                        }
                        .padding(.leading)
                        
                        Group {
                            Text("Place Of Birth")
                                .font(.title2)
                            Text(actor.placeOfBirth ?? "Unknown")
                                .font(.title)
                        }
                        .padding(.leading)
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
        form.unitsStyle = .short
        form.allowedUnits = [.year]
        let age = form.string(from: date, to: Date()) ?? ""
        
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        return "\(dateFormatter.string(from: date)) (\(age))"
    }
    
    private var bio: String {
        actor.biography == "" ? "No Biography Found" : actor.biography
    }
}

#Preview {
    CastDetailView(actor: PersonResponse.example)
}
