//
//  SearchScreenView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/19/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct SearchScreenView: View {
    @State private var searchMovie = ""
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(SearchCategories.allCategories, id: \.self) { category in
                    Button {
                        
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
            
        } detail: {
            Text("content")
        }

    }
}

#Preview {
    SearchScreenView()
}
