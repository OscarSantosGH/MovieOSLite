//
//  MovieDetailView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/11/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: MovieDetailAPIResponse
    
    var body: some View {
        ScrollView {
            ZStack {
                LazyVStack(alignment: .leading) {
                    HeaderDetailsView(movie: movie)
                        .padding(.bottom)
                    
                    Group {
                        Text(overviewLabel)
                            .font(.title)
                            .padding(.vertical)
                        
                        if movie.overview != "" {
                            Text(movie.overview)
                        }
                        
                        Text(trailersLabel)
                            .font(.title)
                            .padding(.top)
                        
                        TrailerListView(trailers: movie.videos.results)
                        
                        Text(castLabel)
                            .font(.title)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(movie.credits.cast, id: \.id) { cast in
                                    CastView(actor: cast)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private var overviewLabel: String {
        if movie.overview == "" {
            NSLocalizedString("No Overview Found", comment: "No Overview Found")
        }else {
            NSLocalizedString("Overview", comment: "Overview")
        }
    }
    
    private var trailersLabel: String {
        if movie.overview == "" {
            NSLocalizedString("No Trailers Found", comment: "No Trailers Found")
        }else {
            NSLocalizedString("Trailers", comment: "Trailers")
        }
    }
    
    private var castLabel: String {
        if movie.credits.cast.isEmpty {
            NSLocalizedString ("No Cast Found", comment: "No Cast Found")
        }else {
            NSLocalizedString("The Cast", comment: "The Cast")
        }
    }
    
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: MovieDetailAPIResponse.example)
    }
}

struct TrailerListView: View {
    let trailers: [VideoResponse]
    @State private var selectedTrailer: VideoResponse?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(trailers) { trailer in
                    Button {
                        selectedTrailer = trailer
                    } label: {
                        VStack {
                            MOImageLoaderView(imagePath: trailer.key, imageType: .trailer)
                                .frame(height: 130)
                                .clipped()
                            Text(trailer.name)
                                .font(.headline)
                                .minimumScaleFactor(0.6)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 5)
                            Spacer()
                        }
                        .frame(width: 230, height: 175)
                        .background(Material.regularMaterial)
                        .hoverEffect(.lift)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationDestination(item: $selectedTrailer) { trailer in
            let viewModel = MovieTrailerViewModel(trailer: trailer)
            MovieTrailerView(viewModel: viewModel)
        }
    }
}
