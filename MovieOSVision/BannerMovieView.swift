//
//  BannerMovieView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/8/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct BannerMovieView: View {
    let id = UUID()
    var title: String
    var imageURLPath: String
    let basePath = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: basePath+imageURLPath)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                LinearGradient(colors: [Color.purple, Color.red],
                               startPoint: UnitPoint(x: 0, y: 0),
                               endPoint: UnitPoint(x: 1, y: 1))
            }
            
            LinearGradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)],
                           startPoint: UnitPoint(x: 0, y: 0),
                           endPoint: UnitPoint(x: 0, y: 1))
            
            VStack {
                HStack {
                    Text(title)
                        .font(.largeTitle)
                        .padding(.top, 30)
                        .padding(.leading, 25)
                    Spacer()
                }
                Spacer()
            }

        }
    }
}

#Preview {
    BannerMovieView(title: "The Best Movie", imageURLPath: "9Le7N3fmrHnWwdxCg35jSSawFyK.jpg")
}
