//
//  Genre.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

// 1. Subclass from `NSSecureUnarchiveFromDataTransformer`
//@objc(GenreValueTransformer)
//final class GenreValueTransformer: NSSecureUnarchiveFromDataTransformer {
//
//    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTransformer(_"forName:)`.
//    static let name = NSValueTransformerName(rawValue: String(describing: GenreValueTransformer.self))
//
//    // 2. Make sure `UIColor` is in the allowed class list.
//    override static var allowedTopLevelClasses: [AnyClass] {
//        return [Genre.self]
//    }
//
//    /// Registers the transformer.
//    public static func register() {
//        let transformer = GenreValueTransformer()
//        ValueTransformer.setValueTransformer(transformer, forName: name)
//    }
//}
