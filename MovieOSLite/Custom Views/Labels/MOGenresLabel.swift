//
//  MOGenresLabel.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 2/21/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

fileprivate let genresDic:Dictionary<Int,String> = [
    28:NSLocalizedString("lsAction", comment: "the gender of the movie is: Action"),
    12:NSLocalizedString("lsAdventure", comment: "the gender of the movie is: Adventure"),
    16:NSLocalizedString("lsAnimation", comment: "the gender of the movie is: Animation"),
    35:NSLocalizedString("lsComedy", comment: "the gender of the movie is: Comedy"),
    80:NSLocalizedString("lsCrime", comment: "the gender of the movie is: Crime"),
    99:NSLocalizedString("lsDocumentary", comment: "the gender of the movie is: Documentary"),
    18:NSLocalizedString("lsDrama", comment: "the gender of the movie is: Drama"),
    10751:NSLocalizedString("lsFamily", comment: "the gender of the movie is: Family"),
    14:NSLocalizedString("lsFantasy", comment: "the gender of the movie is: Fantasy"),
    36:NSLocalizedString("lsHistory", comment: "the gender of the movie is: History"),
    27:NSLocalizedString("lsHorror", comment: "the gender of the movie is: Horror"),
    10402:NSLocalizedString("lsMusic", comment: "the gender of the movie is: Music"),
    9648:NSLocalizedString("lsMystery", comment: "the gender of the movie is: Mystery"),
    10749:NSLocalizedString("lsRomance", comment: "the gender of the movie is: Romance"),
    878:NSLocalizedString("lsScience Fiction", comment: "the gender of the movie is: Science Fiction"),
    10770:NSLocalizedString("lsTV Movie", comment: "the gender of the movie is: TV Movie"),
    53:NSLocalizedString("lsThriller", comment: "the gender of the movie is: Thriller"),
    10752:NSLocalizedString("lsWar", comment: "the gender of the movie is: War"),
    37:NSLocalizedString("lsWestern", comment: "the gender of the movie is: Western")]

class MOGenresLabel: UILabel {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(genresCode code:Int){
        self.init(frame: .zero)
        label.text = genresDic[code]
    }
    
    private func configure(){
        backgroundColor = UIColor(named: "MOSgenderLabelBG")
        layer.cornerRadius = 7
        textColor = UIColor(named: "MOSsecondLabel")
        clipsToBounds = true
        font = UIFont.systemFont(ofSize: 12)
    }
    

}
