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

enum SearchCategories{
    static let allCategories:[MovieCategorySearch] = [
        MovieCategorySearch(title: TMDBGenres.genresDic[16]!, color1: .rgb(red: 255, green: 1, blue: 204), color2: .rgb(red: 51, green: 51, blue: 153), image: UIImage(named: "animation")!, url: "&with_genres=16"),
        MovieCategorySearch(title: TMDBGenres.genresDic[28]!, color1: .rgb(red: 201, green: 75, blue: 75), color2: .rgb(red: 75, green: 18, blue: 78), image: UIImage(named: "action")!, url: "&with_genres=28"),
        MovieCategorySearch(title: TMDBGenres.genresDic[12]!, color1: .rgb(red: 238, green: 9, blue: 121), color2: .rgb(red: 255, green: 106, blue: 0), image: UIImage(named: "superhero")!, url: "&with_genres=12"),
        MovieCategorySearch(title: TMDBGenres.genresDic[14]!, color1: .rgb(red: 91, green: 134, blue: 229), color2: .rgb(red: 0, green: 219, blue: 222), image: UIImage(named: "fantasy")!, url: "&with_genres=14"),
        MovieCategorySearch(title: TMDBGenres.genresDic[27]!, color1: .rgb(red: 43, green: 88, blue: 118), color2: .rgb(red: 79, green: 67, blue: 118), image: UIImage(named: "horror")!, url: "&with_genres=27"),
        MovieCategorySearch(title: TMDBGenres.genresDic[35]!, color1: .rgb(red: 241, green: 39, blue: 17), color2: .rgb(red: 245, green: 175, blue: 25), image: UIImage(named: "comedy")!, url: "&with_genres=35"),
        MovieCategorySearch(title: TMDBGenres.genresDic[53]!, color1: .rgb(red: 195, green: 20, blue: 50), color2: .rgb(red: 35, green: 11, blue: 54), image: UIImage(named: "thriller")!, url: "&with_genres=53"),
        MovieCategorySearch(title: TMDBGenres.genresDic[10749]!, color1: .rgb(red: 252, green: 103, blue: 250), color2: .rgb(red: 242, green: 176, blue: 240), image: UIImage(named: "romance")!, url: "&with_genres=10749"),
        MovieCategorySearch(title: TMDBGenres.genresDic[878]!, color1: .rgb(red: 17, green: 153, blue: 142), color2: .rgb(red: 56, green: 239, blue: 125), image: UIImage(named: "sci-fi")!, url: "&with_genres=878"),
        MovieCategorySearch(title: "1990s", color1: .rgb(red: 62, green: 81, blue: 81), color2: .rgb(red: 222, green: 203, blue: 164), image: UIImage(systemName: "film")!, url: "&release_date.gte=1990-01-01&release_date.lte=1999-12-31")
    ]
}

enum NotificationNames{
    static let internetAvailable = Notification.Name(rawValue: "com.oscarsantos.internetAvailable")
    static let internetNotAvailable = Notification.Name(rawValue: "com.oscarsantos.internetNotAvailable")
}
