//
//  MOGenresLabel.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOGenresLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(genresCode code:Int){
        self.init(frame: .zero)
        text = (TMDBGenres.genresDic[code] ?? "unknown") + "   "
    }
    
    private func configure(){
        backgroundColor = UIColor(named: "MOSgenderLabelBG")
        layer.cornerRadius = 7
        textColor = UIColor(named: "MOSsecondLabel")
        clipsToBounds = true
        font = UIFont.systemFont(ofSize: 12)
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
