//
//  FavoritesScreenView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/21/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI
import SwiftData

struct FavoritesScreenView: View {
    @Query var movies: [Movie]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(movies) { movie in
                    VStack(alignment: .center) {
                        Spacer()
                        
                        Text(movie.title)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(.thinMaterial)
                    }
                    .background {
                        Group {
                            if let imageData = movie.backdropImage,
                               let image = UIImage(data: imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Color.primary
                            }
                        }
                        .ignoresSafeArea()
                    }
                }
            }
        } detail: {
            Text("Movie Details")
        }

    }
}

#Preview {
    FavoritesScreenView()
}
