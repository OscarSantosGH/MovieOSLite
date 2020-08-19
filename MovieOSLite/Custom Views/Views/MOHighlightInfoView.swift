//
//  MOHighlightInfoView.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 3/6/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class MOHighlightInfoView: UIView {

    var infoLabel = MOTitleLabel(ofSize: 18, textAlignment: .left, textColor: UIColor(named: "MOSorange")!)
    var descLabel = MOBodyLabel(alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(info:String, desc:String){
        self.init(frame: .zero)
        infoLabel.text = info
        infoLabel.baselineAdjustment = .alignBaselines
        descLabel.text = desc
    }
    
    convenience init(desc:String){
        self.init(frame: .zero)
        descLabel.text = desc
    }
    
    func update(info:String){
        infoLabel.text = info
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(infoLabel, descLabel)
        
        let padding:CGFloat = 5
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            infoLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor),
            descLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            descLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            descLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
