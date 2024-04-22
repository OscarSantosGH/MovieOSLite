//
//  Video.swift
//  MovieOSVision
//
//  Created by Oscar Santos on 4/22/24.
//  Copyright © 2024 Oscar Santos. All rights reserved.
//

import Foundation
import SwiftData

@Model
class Video {
    var id: String
    var key: String
    var name: String
    var site: String
    var size: Int
    var type: String
    
    init(id: String, key: String, name: String, site: String, size: Int, type: String) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
    
    convenience init(from videoResponse: VideoResponse) {
        self.init(id: videoResponse.id,
                  key: videoResponse.key,
                  name: videoResponse.name,
                  site: videoResponse.site,
                  size: videoResponse.size,
                  type: videoResponse.type)
    }
}
