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
    var totalWidth:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withGenres codes:[Int], parentWidth viewWidth:CGFloat){
        self.init(frame: .zero)
        totalWidth = 279
        for code in codes{
            let newLabel = MOGenresLabel(genresCode: code)
            genresLabels.append(newLabel)
        }
        addGenreLabelToStackView()
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
    
    private func addGenreLabelToStackView(){
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
                print("lastRow frame width + label widht: \(lastRowStackView.frame.width + label.intrinsicContentSize.width)")
                print("frame width: \(self.totalWidth)")
                if (lastRowStackView.frame.width + label.intrinsicContentSize.width) < self.totalWidth{
                    lastRowStackView.addArrangedSubview(label)
                    self.addArrangedSubview(lastRowStackView)
                    print("new label")
                }else{
                    let newRowStackView = getNewRowStackView()
                    newRowStackView.addArrangedSubview(label)
                    self.addArrangedSubview(newRowStackView)
                    print("new row")
                }
            }
        }
    }
    
    
}
