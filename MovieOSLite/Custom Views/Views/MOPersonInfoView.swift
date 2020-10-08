//
//  MOPersonInfoView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 8/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOPersonInfoView: UIView {
    let posterImageView = MOPersonProfileImageView(frame: .zero)
    let nameLabel = MOTitleLabel(ofSize: 25, textAlignment: .left)
    var birthdayLabel = MOHighlightInfoView(frame: .zero)
    var placeOfBirthLabel = MOHighlightInfoView(frame: .zero)
    let biographyLabel = MOTitleLabel(ofSize: 15, textAlignment: .left)
    let biographyBodyLabel = MOBodyLabel(alignment: .left)
    
    var person:PersonResponse!
    var isSaved = false
    var profileImage:UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withPerson person:PersonResponse, profileImage:UIImage?, isSaved:Bool, profileImageDelegate:PersonDetailsVC){
        self.init(frame: .zero)
        self.person = person
        self.isSaved = isSaved
        self.profileImage = profileImage
        posterImageView.delegate = profileImageDelegate
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.systemBackground
        if isSaved{
            posterImageView.image = profileImage
        }else{
            posterImageView.setImage(forURL: person.profilePath)
        }
        nameLabel.text = person.name
        birthdayLabel = MOHighlightInfoView(info: getAgeFromString(stringDate: person.birthday), desc: NSLocalizedString("Age", comment: "Age"))
        placeOfBirthLabel = MOHighlightInfoView(info: person.placeOfBirth ?? NSLocalizedString("Unknown", comment: "Unknown"), desc: NSLocalizedString("Place Of Birth", comment: "Place Of Birth"))
        if person.biography == ""{
            biographyLabel.text = NSLocalizedString("No Biography Found", comment: "No Biography Found")
        }else{
            biographyLabel.text = NSLocalizedString("Biography", comment: "Biography")
        }
        
        biographyBodyLabel.text = person.biography
    }
    
    private func getAgeFromString(stringDate:String?) -> String{
        guard let stringDateFromTMDB = stringDate else {return "??"}
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from:stringDateFromTMDB) else {return "??"}
        
        let form = DateComponentsFormatter()
        form.maximumUnitCount = 3
        form.unitsStyle = .full
        form.allowedUnits = [.year]
        let s = form.string(from: date, to: Date())
        
        var age = ""
        
        for c in s!{
            if c == " "{
                break
            }else{
                age.append(c)
            }
        }
        
        return age
    }
    
    private func layoutUI(){
        addSubviews(posterImageView,
                    nameLabel,
                    birthdayLabel,
                    placeOfBirthLabel,
                    biographyLabel,
                    biographyBodyLabel
        )
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: 111),
            posterImageView.heightAnchor.constraint(equalToConstant: 152),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 45),

            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            birthdayLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding),
            birthdayLabel.widthAnchor.constraint(equalToConstant: 35),
            birthdayLabel.heightAnchor.constraint(equalToConstant: 60),

            placeOfBirthLabel.topAnchor.constraint(equalTo: birthdayLabel.topAnchor),
            placeOfBirthLabel.leadingAnchor.constraint(equalTo: birthdayLabel.trailingAnchor, constant: padding),
            placeOfBirthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            placeOfBirthLabel.heightAnchor.constraint(equalTo: birthdayLabel.heightAnchor),

            biographyLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 35),
            biographyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            biographyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            biographyLabel.heightAnchor.constraint(equalToConstant: 20),

            biographyBodyLabel.topAnchor.constraint(equalTo: biographyLabel.bottomAnchor, constant: padding),
            biographyBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            biographyBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            biographyBodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
