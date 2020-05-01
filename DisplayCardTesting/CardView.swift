//
//  CardView.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/26/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var lineView = UIView()
    var bodyView = UIView()
    var grabView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 15

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        
        addSubview(bodyView)
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.layer.borderWidth = 1
        bodyView.layer.borderColor = UIColor.gray.cgColor
        bodyView.backgroundColor = .systemPink
        
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .systemGray
        lineView.layer.cornerRadius = 2
        
        addSubview(grabView)
        grabView.translatesAutoresizingMaskIntoConstraints = false
        grabView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            bodyView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bodyView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            bodyView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            lineView.widthAnchor.constraint(equalToConstant: 100),
            lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 3),
            lineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 23.5),
            
            grabView.topAnchor.constraint(equalTo: self.topAnchor),
            grabView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            grabView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            grabView.bottomAnchor.constraint(equalTo: bodyView.topAnchor)
        ])
    }
    
    

}
