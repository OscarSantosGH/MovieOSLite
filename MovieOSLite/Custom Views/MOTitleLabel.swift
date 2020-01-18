//
//  MOTitleLabel.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/17/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

enum MOLabelSize: CGFloat{
    case small = 12
    case big = 22
}

class MOTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(of size:MOLabelSize) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
        configure()
    }
    
    private func configure(){
        textColor = .label
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
