//
//  CastView.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 3/17/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import SwiftUI

struct CastView: View {
    var actor: ActorResponse
    var profileImage: (Data?) -> Void
    
    var body: some View {
        VStack {
            MOImageLoaderView(imagePath: actor.profilePath, imageType: .cast) { imageData in
                profileImage(imageData)
            }
            .frame(height: 330)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            VStack(spacing: 10) {
                Text(actor.name)
                    .frame(height: 40)
                    .font(.title2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                Text(actor.character)
                    .frame(height: 40)
                    .font(.title2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundStyle(.orange)
                    .padding(.bottom)
                
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(width: 250, height: 420)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    CastView(actor: MovieDetailAPIResponse.example.credits.cast.first!) { _ in }
}
