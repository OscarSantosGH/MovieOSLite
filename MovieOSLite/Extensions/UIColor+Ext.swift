//
//  UIColor+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat = 1) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
