//
//  CollectionViewCell.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
    
    static let reuseID = "CollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        backgroundColor = .white
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1
        label.textAlignment = .center
        label.text = "|"
        label.layer.borderColor = UIColor.systemPink.cgColor
        label.layer.borderWidth = 1
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
