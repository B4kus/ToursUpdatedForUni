//
//  CityToursView.swift
//  Tours
//
//  Created by Szymon Szysz on 02/11/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

import UIKit

final class CityToursView: UIView {
    
    //MARK: - Views
    
    let collectionView: UICollectionView = Subviews.collectionView
 
    //MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupSelf()
    }
    
    required init?(coder aDecoder: NSCoder) { assertionFailure(); return nil }
    
    //MARK: - Setup
    
    private func setupSelf() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        collectionView.activate(constraints: [
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private enum Subviews {
    
    private static var collectionViewLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Layout.Spacing.large
        layout.scrollDirection = .vertical
        return layout
    }
    
    static var collectionView: UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.contentInset = UIEdgeInsets(top: Layout.Spacing.large, left: 0, bottom: 0, right: 0)
        cv.scrollIndicatorInsets = UIEdgeInsets(top: Layout.Spacing.large, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .white
        cv.register(TourCollectionViewCell.self, forCellWithReuseIdentifier: TourCollectionViewCell.reuseIdentifier)
        return cv
    }
}
