//
//  UIHelper.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

class UIHelper {

    static func createThreeColumnsLayout(in view:UIView) -> UICollectionViewLayout{
        let width = view.bounds.width
        let padding: CGFloat = 1
        let minimunItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimunItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 245)
        
        return flowLayout
    }

}
