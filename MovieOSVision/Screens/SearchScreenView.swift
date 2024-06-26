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
    @State private var columnVisibility =
    NavigationSplitViewVisibility.all
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 250)),
    ]
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
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
                    NavigationStack {
                        VStack {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach(viewModel.movies, id: \.id) { movie in
                                        PosterDetailView(posterPath: movie.posterPath,title: movie.title, rating: movie.voteAverage) {
                                            viewModel.presentMovieDetails(movie: movie)
                                        }
                                        .padding(.vertical)
                                    }
                                }
                            }
                        }
                        .navigationTitle(searchTitle)
                        .navigationDestination(item: $viewModel.selectedMovie) { movie in
                            MovieDetailView(movie: movie)
                        }
                    }
                    
                }
            }
        }
        .onChange(of: viewModel.selectedMovie) { _, selectedMovie in
            if selectedMovie != nil {
                columnVisibility = .detailOnly
            } else {
                columnVisibility = .all
            }
        }

    }
}

#Preview {
    SearchScreenView()
}
