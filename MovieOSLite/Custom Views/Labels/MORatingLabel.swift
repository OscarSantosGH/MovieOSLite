//
//  MORatingLabel.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/19/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MORatingLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(ofSize size:CGFloat, textAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size, weight: .black)
        self.textAlignment = textAlignment
    }
    
    private func configure(){
        textColor = .systemOrange
        textAlignment = .center
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
