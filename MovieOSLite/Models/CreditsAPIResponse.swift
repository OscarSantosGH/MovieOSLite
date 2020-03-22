//
//  CreditsAPIResponse.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

struct CreditsAPIResponse: Codable {
    let id: Int
    let cast: [Actor]
}
