//
//  UIHelper.swift
//  MovieOSLite
//
//  Created by Oscar Santos on 1/23/20.
//  Copyright © 2020 Oscar Santos. All rights reserved.
//

import UIKit

enum UIHelper {

    static let titleElementKind = "title-element-kind"
    
    enum Section: Int, CaseIterable{
        case feature
        case popular
        case nowPlaying
        case upcoming
        
        var title: String{
            switch self {
            case .feature:
                return "Feature"
            case .popular:
                return "Popular"
            case .nowPlaying:
                return "Now Playing"
            case .upcoming:
                return "Upcoming"
            }
        }
    }
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimunItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimunItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 245)
        
        return flowLayout
    }
    
    static func create2ColumnsLayout(with width:CGFloat) -> UICollectionViewLayout{
        let padding: CGFloat = 5
        let availableWidth = width - (padding * 4) - 16
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth/1.5)
        
        return flowLayout
    }
    
    static func createHomeLayout() -> UICollectionViewLayout {
            let sectionProvider = { (sectionIndex: Int,
                layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
                let groupWidth = sectionKind.rawValue == 0 ? NSCollectionLayoutDimension.fractionalWidth(0.94) : NSCollectionLayoutDimension.fractionalWidth(0.30)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                                      heightDimension: .absolute(245))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0)
                
                if sectionKind.rawValue == 0{
                    section.orthogonalScrollingBehavior = .groupPagingCentered
                }else{
                    let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .estimated(20))
                    let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: titleSize,
                        elementKind: titleElementKind,
                        alignment: .top)
                    section.boundarySupplementaryItems = [titleSupplementary]
                    section.orthogonalScrollingBehavior = .continuous
                }
                
                return section
            }

            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.interSectionSpacing = 20

            let layout = UICollectionViewCompositionalLayout(
                sectionProvider: sectionProvider, configuration: config)
            return layout
        }
    
    static func createOneHorizontalLayout(withHeight height:CGFloat) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupWidth = NSCollectionLayoutDimension.fractionalWidth(0.30)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                              heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}
