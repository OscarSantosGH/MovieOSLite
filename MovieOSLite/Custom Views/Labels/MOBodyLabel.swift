//
//  MOBodyLabel.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/19/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignment:NSTextAlignment) {
        super.init(frame: .zero)
        textAlignment = alignment
        configure()
    }
    
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
