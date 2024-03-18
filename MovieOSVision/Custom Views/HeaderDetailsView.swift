//
//  HeaderDetailsView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/17/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct HeaderDetailsView: View {
    var movie: MovieDetailAPIResponse
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                MOImageLoaderView(imagePath: movie.posterPath, imageType: .poster)
                    .frame(width: 200, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.extraLargeTitle)
                    
                    HStack {
                        Text(NSLocalizedString("Release Date", comment: "Release Date")+":")
                        Text(configureReleaseDate(from: movie.releaseDate))
                    }
                    
                    HStack(spacing: 20) {
                        HStack(spacing: 15) {
                            CircularRatingView(percentage: movie.voteAverage)
                                .frame(width: 75, height: 75)
                            VStack(alignment: .leading) {
                                Group {
                                    //TODO: create localization for user score
                                    Text("User")
                                    Text("Score")
                                }
                                .font(.title2)
                            }
                        }
                        .padding(.trailing)
                        
                        Button {
                            //TODO: Add to favorite
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 200, height: 50)
                                .foregroundStyle(.moSorange)
                                .overlay {
                                    //TODO: Add localization and make it responsive
                                    HStack {
                                        Text("Add to Favorite")
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName: "heart.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(5)
                                    }
                                    .padding(.leading)
                                }
                        }
                        .buttonStyle(.plain)
                        
                    }
                    .padding()
                    
                    GenresGridView(genres: movie.genres)
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func configureReleaseDate(from stringDate:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:stringDate) else {return NSLocalizedString("Unknown", comment: "Unknown")}
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, yyyy"
        
        return newFormatter.string(from: date)
    }
}

#Preview {
    HeaderDetailsView(movie: MovieDetailAPIResponse.example)
}

struct CircularRatingView: View {
    var percentage: Float
    var lineWidth: CGFloat = 10
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Material.thick,
                    lineWidth: lineWidth + 5
                )
                .background(Circle())
                .foregroundStyle(Material.thick)
                
                
            Circle()
                .stroke(
                    Color.green.opacity(0.3),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: CGFloat(percentage)/10)
                .stroke(
                    Color.green,
                    style: StrokeStyle (
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            
            HStack(alignment: .top, spacing: 0) {
                Text(displayPercentage)
                    .font(.title2)
                    .bold()
                
                Text("%")
                    .font(.caption)
                    .bold()
            }
        }
    }
    
    private var displayPercentage: String {
        String(Int(percentage*10))
    }
}
