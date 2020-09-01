//
//  VideoResponse.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/1/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct VideoResponse: Codable {
    let id:String
    let key:String
    let name:String
    let site:String
    let size:Int
    let type:String
}
