//
//  SearchScreenView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/19/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct SearchScreenView: View {
    @State private var searchTitle = ""
    @State private var searchMovie = ""
    @State private var viewModel = SearchScreenViewModel()
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 250)),
    ]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(SearchCategories.allCategories, id: \.self) { category in
                    Button {
                        Task {
                            await viewModel.getMoviesByCategory(withCategoryURL: category.url)
                            searchTitle = category.title
                        }
                    } label: {
                        Label {
                            Text(category.title)
                        } icon: {
                            Image(uiImage: category.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(Gradient(colors: [Color.init(uiColor: category.color1), Color.init(uiColor: category.color2)]))
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .searchable(text: $searchMovie)
            .onChange(of: searchMovie) { _, movieName in
                Task {
                    await viewModel.getMoviesBySearch(movieName: movieName)
                    searchTitle = movieName
                }
            }
            
        } detail: {
            if viewModel.isLoadingMovies {
                ProgressView()
            } else {
                if viewModel.movies.isEmpty {
                    Text("Search for movies")
                } else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(viewModel.movies, id: \.id) { movie in
                                    PosterDetailView(posterPath: movie.posterPath,title: movie.title, rating: movie.voteAverage) {
                                        //TODO: navigate to movie details
                                    }
                                    .padding(.vertical)
                                }
                            }
                        }
                    }
                    .navigationTitle(searchTitle)
                }
            }
        }

    }
}

#Preview {
    SearchScreenView()
}
