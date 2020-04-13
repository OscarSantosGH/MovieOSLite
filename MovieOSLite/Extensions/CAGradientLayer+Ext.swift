//
//  CAGradientLayer+Ext.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 4/12/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0.1)
        endPoint = CGPoint(x: 0, y: 1)
    }
    
}
