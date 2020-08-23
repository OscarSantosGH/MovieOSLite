//
//  Genre.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import Foundation

public class Genre: NSObject, NSCoding {
    let id: Int32
    let name: NSString
    
    init(id:Int32, name:NSString){
        self.id = id
        self.name = name
    }
    
    convenience init(id:Int, name:String){
        self.init(id: Int32(id), name: NSString(string: name))
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "name")
    }
   
    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInt32(forKey: "id")
        let name = coder.decodeObject(forKey: "name") as! NSString
        self.init(id: id, name: name)
    }
}
