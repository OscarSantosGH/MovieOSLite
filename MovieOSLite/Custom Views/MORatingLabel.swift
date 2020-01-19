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
    
    init(ofSize size:CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size, weight: .black)
        configure()
    }
    
    private func configure(){
        textColor = .systemOrange
        textAlignment = .center
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
