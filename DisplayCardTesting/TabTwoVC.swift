//
//  TabTwoVC.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/26/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class TabTwoVC: UIViewController {
    
    enum Section {
        case main
    }

    var currentSnapshot : NSDiffableDataSourceSnapshot<Section,String>!
    var dataSource      : UICollectionViewDiffableDataSource<Section,String>!
    var counterLabel    = "Holder"
    var collectionView  : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupCollectionView()
        configureCollectionViewDataSource()
        setData()
    }
    
    private func configure() {
        view.backgroundColor = .systemGray
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout.customLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, string) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
            
            return cell
        })
        
        
    }
    
    private func setData() {
        var array : [String] = []
        for x in 0...100 {
            array.append(String(x))
        }
        currentSnapshot = NSDiffableDataSourceSnapshot<Section,String>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(array)
        dataSource.apply(currentSnapshot)
        
    }
}
