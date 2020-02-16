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
    
    static func createHomeLayout() -> UICollectionViewLayout {
            let sectionProvider = { (sectionIndex: Int,
                layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // if we have the space, adapt and go 2-up + peeking 3rd item
    //            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ?
    //                0.425 : 0.85)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.30),
                                                      heightDimension: .absolute(245))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 5
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0)

    //            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
    //                                                  heightDimension: .estimated(44))
    //            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
    //                layoutSize: titleSize,
    //                elementKind: ConferenceVideoSessionsViewController.titleElementKind,
    //                alignment: .top)
    //            section.boundarySupplementaryItems = [titleSupplementary]
                return section
            }

            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.interSectionSpacing = 20

            let layout = UICollectionViewCompositionalLayout(
                sectionProvider: sectionProvider, configuration: config)
            return layout
        }

}
