//
//  Video+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/2/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import CoreData

extension Video{
    func setDataFromVideoResponse(videoResponse: VideoResponse){
        id = videoResponse.id
        key = videoResponse.key
        name = videoResponse.name
        site = videoResponse.site
        size = Int32(videoResponse.size)
        type = videoResponse.type
    }
    
    func getVideoResponse() -> VideoResponse{
        VideoResponse(id: id!, key: key!, name: name!, site: site!, size: Int(size), type: type!)
    }
}
