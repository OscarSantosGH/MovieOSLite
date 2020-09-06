//
//  MOSearchCategoryView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 9/5/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOSearchCategoryView: UIView {
    let myScrollView = UIScrollView()
    let contentView = UIView()
    let mainStackView = UIStackView()
    
    var categoryButtons:[MOMovieCategoryButtonView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        
    }
    
    func prepare(){
        addSubview(myScrollView)
        myScrollView.pinToEdges(of: self)
        myScrollView.addSubview(contentView)
        contentView.pinToEdges(of: myScrollView)
        contentView.addSubview(mainStackView)
        //mainStackView.pinToEdges(of: contentView)
        myScrollView.showsVerticalScrollIndicator = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor),
            //contentView.heightAnchor.constraint(equalTo: myScrollView.heightAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        addCategoryButtons()
        addButtonsToStackView()
    }
    
    private func addButtonsToStackView(){
        var counter = 0
        let firstRow = getNewRowStackView()
        mainStackView.addArrangedSubview(firstRow)
        mainStackView.layoutIfNeeded()
        
        for button in categoryButtons{
            if counter == 2{
                let newRow = getNewRowStackView()
                newRow.addArrangedSubview(button)
                mainStackView.addArrangedSubview(newRow)
                button.layoutIfNeeded()
                button.activateGradient()
                counter = 1
            }else{
                let lastRowStackView = mainStackView.arrangedSubviews.last as! UIStackView
                lastRowStackView.addArrangedSubview(button)
                button.layoutIfNeeded()
                button.activateGradient()
                counter += 1
            }
        }
        
        mainStackView.layoutSubviews()
    }
    
    private func getNewRowStackView() -> UIStackView{
           let rowStackView = UIStackView()
           rowStackView.axis = .horizontal
        rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
           rowStackView.spacing = 10
           rowStackView.translatesAutoresizingMaskIntoConstraints = false
           return rowStackView
       }
    
    private func addCategoryButtons(){
        let actionButton = MOMovieCategoryButtonView(title: "Action", color1: .rgb(red: 195, green: 20, blue: 50), color2: .rgb(red: 35, green: 11, blue: 54), image: UIImage(named: "action")!)
        let animationButton = MOMovieCategoryButtonView(title: "Animation", color1: .rgb(red: 255, green: 1, blue: 204), color2: .rgb(red: 51, green: 51, blue: 153), image: UIImage(named: "animation")!)
        let comedyButton = MOMovieCategoryButtonView(title: "Comedy", color1: .rgb(red: 241, green: 39, blue: 17), color2: .rgb(red: 245, green: 175, blue: 25), image: UIImage(named: "comedy")!)
        let fantasyButton = MOMovieCategoryButtonView(title: "Fantasy", color1: .rgb(red: 106, green: 48, blue: 147), color2: .rgb(red: 160, green: 68, blue: 255), image: UIImage(named: "fantasy")!)
        let thrillerButton = MOMovieCategoryButtonView(title: "Thriller", color1: .rgb(red: 195, green: 20, blue: 50), color2: .rgb(red: 35, green: 11, blue: 54), image: UIImage(named: "thriller")!)
        let horrorButton = MOMovieCategoryButtonView(title: "Horror", color1: .rgb(red: 43, green: 88, blue: 118), color2: .rgb(red: 79, green: 67, blue: 118), image: UIImage(named: "horror")!)
        let romanceButton = MOMovieCategoryButtonView(title: "Romance", color1: .rgb(red: 242, green: 176, blue: 240), color2: .rgb(red: 252, green: 103, blue: 250), image: UIImage(named: "romance")!)
        let scifiButton = MOMovieCategoryButtonView(title: "Sci-Fi", color1: .rgb(red: 17, green: 153, blue: 142), color2: .rgb(red: 56, green: 239, blue: 125), image: UIImage(named: "sci-fi")!)
        let superheroButton = MOMovieCategoryButtonView(title: "Superhero", color1: .rgb(red: 238, green: 9, blue: 121), color2: .rgb(red: 255, green: 106, blue: 0), image: UIImage(named: "superhero")!)
        let ninetyButton = MOMovieCategoryButtonView(title: "1990s", color1: .rgb(red: 62, green: 81, blue: 81), color2: .rgb(red: 222, green: 203, blue: 164), image: UIImage(systemName: "film")!)
        
        categoryButtons.append(actionButton)
        categoryButtons.append(animationButton)
        categoryButtons.append(comedyButton)
        categoryButtons.append(fantasyButton)
        categoryButtons.append(thrillerButton)
        categoryButtons.append(horrorButton)
        categoryButtons.append(romanceButton)
        categoryButtons.append(scifiButton)
        categoryButtons.append(superheroButton)
        categoryButtons.append(ninetyButton)
    }
    
}
