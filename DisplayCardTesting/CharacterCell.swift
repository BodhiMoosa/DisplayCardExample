//
//  CharacterCell.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/26/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    var label = UILabel()
    
    static let reuseID = "CharacterCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String, alignment: NSTextAlignment) {
        label.text = title
        label.textAlignment = alignment
    }
    private func configure() {
        selectionStyle = .none
        backgroundColor = .systemTeal
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }

}
