//
//  Constants.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/22/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum MOElementsSize{
    static let DetailMoviePosterWidth = ScreenSize.width * 0.27
    static let GenresStackiewWidth = ScreenSize.width * 0.673
}

enum TMDBGenres{
    static let genresDic:Dictionary<Int,String> = [
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
}
