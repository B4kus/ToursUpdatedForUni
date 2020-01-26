//
//  TourView.swift
//  Tours
//
//  Created by Szymon Szysz on 02.07.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import UIKit
import SDWebImage

final class TourView: UIView {
    
    let continerView: UIView = Subviews.viewtest
    let cityTitle: UILabel = Subviews.title
    let cityPhoto: UIImageView = Subviews.cityPhoto
    let cityInfo: UITextView = Subviews.cityInfo
    let collectionView: UICollectionView = Subviews.collectionView
    let emptyView: EmptyView = Subviews.emptyView
        
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupSelf()
    }
    
    required init?(coder: NSCoder) { return nil }
    
    private func setupSelf() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        
        addSubview(continerView)
        continerView.activate(constraints: [
            continerView.topAnchor.constraint(equalTo: topAnchor),
            continerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            continerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            continerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33)
        ])
        
        addSubview(collectionView)
        collectionView.activate(constraints: [
            collectionView.topAnchor.constraint(equalTo: continerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        continerView.addSubview(cityPhoto)
        cityPhoto.activate(constraints: cityPhoto.constraints(forEdgeEqualTo: continerView))
        
        continerView.addSubview(cityTitle)
        cityTitle.activate(constraints: [
            cityTitle.topAnchor.constraint(equalTo: continerView.topAnchor),
            cityTitle.leadingAnchor.constraint(equalTo: continerView.leadingAnchor),
            cityTitle.trailingAnchor.constraint(equalTo: continerView.trailingAnchor)
        ])

        continerView.addSubview(cityInfo)
        cityInfo.activate(constraints: [
            cityInfo.topAnchor.constraint(equalTo: cityTitle.bottomAnchor),
            cityInfo.leadingAnchor.constraint(equalTo: continerView.leadingAnchor),
            cityInfo.trailingAnchor.constraint(equalTo: continerView.trailingAnchor),
            cityInfo.bottomAnchor.constraint(equalTo: continerView.bottomAnchor, constant: -Layout.Spacing.large)
        ])
        
        addSubview(emptyView)
        emptyView.activate(constraints: emptyView.constraints(forEdgeEqualTo: self))
    }
    
    
    func bind(model: CitiesList) {
        cityTitle.text = model.cityName
        cityInfo.text = model.cityDescription
        cityPhoto.sd_setImage(with: URL(string: model.cityPhoto ?? ""), placeholderImage: #imageLiteral(resourceName: "Plik00003"), options: .refreshCached, completed: nil)
    }
}

private enum Subviews {
    
    static var viewtest: UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }

    static var cityPhoto: UIImageView {
        let image = UIImageView()
        image.backgroundColor = .white
        return image
    }
    
    static var title: UILabel {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = systemBoldFont(size: 24)
        label.isHidden = true
        label.textAlignment = .center
        return label
    }
    
    static var cityInfo: UITextView {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = systemThinFont(size: 18)
        textView.isHidden = true
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.isSelectable = false
        return textView
    }
    
    private static var collectionViewLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Layout.Spacing.large
        layout.scrollDirection = .vertical
        return layout
    }
    
    static var collectionView: UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = ColorPalette.Main.white
        cv.register(TourCollectionViewCell.self, forCellWithReuseIdentifier: TourCollectionViewCell.reuseIdentifier)
        cv.contentInset = UIEdgeInsets(top: Layout.Spacing.large, left: 0, bottom: 0, right: 0)
        cv.scrollIndicatorInsets = UIEdgeInsets(top: Layout.Spacing.large, left: 0, bottom: 0, right: 0)
        return cv
    }
    
    static var emptyView: EmptyView {
        let emptyView = EmptyView()
        emptyView.isHidden = true
        return emptyView
    }
}

