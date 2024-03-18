//
//  GenresGridView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/17/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

//TODO: Find a better way of creating a dynamic genres view grid
struct GenresGridView: View {
    var genres: [GenreResponse]
    @State private var currentRowWidth: CGFloat = 0
    @State private var currentRowGenres: [GenreResponse] = []
    @State private var genresGrid: [[GenreResponse]] = []
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                ForEach(0..<genresGrid.count, id: \.self) { rowIndex in
                    let genreRow = genresGrid[rowIndex]
                    HStack {
                        ForEach(genreRow, id: \.id) { genre in
                            Text(genre.name)
                                .font(.headline)
                                .padding(.horizontal)
                                .background(Material.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .padding(.top)
                        }
                    }
                }
            }
            .onAppear {
                calculateRowWidth(viewWidth: geo.size.width)
            }
        }
    }
    
    private func calculateRowWidth(viewWidth: CGFloat) {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        
        for (index, genre) in genres.enumerated() {
            let size = genre.name.size(withAttributes: fontAttributes)
            let padding: CGFloat = 70
            currentRowWidth += (size.width + padding)
            
            if currentRowWidth < viewWidth {
                currentRowGenres.append(genre)
            } else {
                currentRowGenres.append(genre)
                genresGrid.append(currentRowGenres)
                currentRowWidth = 0
                currentRowGenres = []
            }
        }
        genresGrid.append(currentRowGenres)
    }
}

#Preview {
    let genres = Array(repeating: GenreResponse(id: 878, name: "Science Fiction"), count: 15)
    return GenresGridView(genres: genres)
}
