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
    @State private var relatedMovies: [MovieResponse] = []
    @State private var selectedMovie: MovieDetailAPIResponse?
    
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
                                .font(.title3)
                            Text(age)
                                .font(.title)
                                .padding(.bottom)
                        }
                        .padding(.leading)
                        
                        Group {
                            Text("Place Of Birth")
                                .font(.title3)
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
                
                Text(knownForLabel)
                    .font(.title)
                    .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(actor.movieCredits.cast, id: \.id) { cast in
                            PosterDetailView(posterPath: cast.posterPath,
                                             title: cast.title,
                                             value: cast.character,
                                             style: .subtitle) {
                                presentMovieDetails(movieID: cast.id)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationDestination(item: $selectedMovie) { movie in
                MovieDetailView(movie: movie)
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
    
    private var knownForLabel: String {
        if actor.movieCredits.cast.count == 0 {
            NSLocalizedString("No Movie Credit Found", comment: "No Movie Credit Found")
        } else {
            NSLocalizedString("Known For", comment: "Known For")
        }
    }
    
    private func presentMovieDetails(movieID: Int) {
        //TODO: Make some loading animation while downloading the movie details
        Task {
            let response = await TMDBClient.shared.getMovie(withID: movieID)
            
            switch response {
            case .success(let movieDetails):
                selectedMovie = movieDetails
            case .failure(let error):
                //TODO: Create a view to display some message to the user to informed that the movie details fetching fails
                print("Error getting movie details: \(error)")
            }
        }
    }
}

#Preview {
    CastDetailView(actor: PersonResponse.example)
}
