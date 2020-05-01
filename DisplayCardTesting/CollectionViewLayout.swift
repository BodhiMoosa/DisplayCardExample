//
//  CollectionViewLayout.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

struct CollectionViewLayout {
    static func customLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.05), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
}
