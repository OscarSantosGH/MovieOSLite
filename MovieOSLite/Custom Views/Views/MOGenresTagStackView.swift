//
//  MOGenderTagStackView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/16/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOGenresTagStackView: UIStackView {

    var genresLabels:[MOGenresLabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withGenres codes:[Int]){
        self.init(frame: .zero)
        for code in codes{
            let newLabel = MOGenresLabel(genresCode: code)
            genresLabels.append(newLabel)
        }
        layoutGenresLabels()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fillEqually
        alignment = .leading
        spacing = 5
    }
    
    private func getNewRowStackView() -> UIStackView{
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.alignment = .center
        rowStackView.distribution = .equalSpacing
        rowStackView.spacing = 2
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        return rowStackView
    }
    
    func layoutGenresLabels(){
        layoutIfNeeded()
        var isFirstGenreLoad = true
        
        for label in genresLabels{
            if isFirstGenreLoad{
                let newRowStackView = getNewRowStackView()
                newRowStackView.addArrangedSubview(label)
                self.addArrangedSubview(newRowStackView)
                isFirstGenreLoad = false
            }else{
                let lastRowStackView = self.arrangedSubviews.last as! UIStackView
                lastRowStackView.layoutIfNeeded()
                if (lastRowStackView.frame.width + label.intrinsicContentSize.width) < MOElementsSize.GenresStackiewWidth{
                    lastRowStackView.addArrangedSubview(label)
                    self.addArrangedSubview(lastRowStackView)
                }else{
                    let newRowStackView = getNewRowStackView()
                    newRowStackView.addArrangedSubview(label)
                    self.addArrangedSubview(newRowStackView)
                }
            }
        }
    }
    
    
}
