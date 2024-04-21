//
//  MovieOSVisionApp.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/4/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct MovieOSVisionApp: App {
    var body: some Scene {
        WindowGroup {
            LoadingView()
        }
        .windowStyle(.plain)
        .modelContainer(for: Movie.self)
    }
}
