//
//  TitleSupplementaryView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/15/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    
    let label = MOTitleLabel(ofSize: 15, textAlignment: .left)
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        addSubview(label)
        label.adjustsFontForContentSizeCategory = true
        label.pinToEdges(of: self, withPadding: 5)
    }
}
