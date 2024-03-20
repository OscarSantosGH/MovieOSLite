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
                    Label {
                        Text(category.title)
                    } icon: {
                        Image(uiImage: category.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.white)
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
