//
//  VideoResponse.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/1/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct VideoResponse: Codable, Hashable, Identifiable {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    static let example = VideoResponse(id: "65ebc0ca28723c01643e7dd4", key: "Xq6OPXGEzBo", name: "This or That", site: "YouTube", size: 1080, type: "Featurette")
}
