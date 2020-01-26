//
//  TourCollectionViewCell.swift
//  Tours
//
//  Created by Szymon Szysz on 24.06.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import UIKit

final class TourCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    
    let shadowView: UIView = Subviews.shadowView
    let thumbnailImageView: UIImageView = Subviews.thumbnailImageView
    let tourTimeLabel: UILabel = Subviews.tourTimeLabel
    let cityNameLabel: UILabel = Subviews.titleLabel
    let subTitle: UILabel = Subviews.subTitle
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) { return nil }

    //MARK: - Setup
    
    private func setupLayout() {
        
        contentView.addSubview(shadowView)
        shadowView.activate(constraints: [
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.Spacing.large),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.large),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.Spacing.large)
        ])
        
        contentView.addSubview(cityNameLabel)
        cityNameLabel.activate(constraints: [
            cityNameLabel.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: Layout.Spacing.normal),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.large),
        ])
        cityNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        shadowView.addSubview(thumbnailImageView)
        thumbnailImageView.activate(constraints: thumbnailImageView.constraints(forEdgeEqualTo: shadowView))
        shadowView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        contentView.addSubview(tourTimeLabel)
        tourTimeLabel.activate(constraints: [
            tourTimeLabel.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: Layout.Spacing.normal),
            tourTimeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: cityNameLabel.trailingAnchor, constant: Layout.Spacing.large),
            tourTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.Spacing.large),
            tourTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.Spacing.large)
        ])
        
        contentView.addSubview(subTitle)
        subTitle.activate(constraints: [
            subTitle.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: Layout.Spacing.normal),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.Spacing.large),
            subTitle.trailingAnchor.constraint(equalTo: tourTimeLabel.leadingAnchor, constant: -Layout.Spacing.large),
            subTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.Spacing.large)
        ])
        subTitle.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func bind(viewModel: CitiesList) {
        cityNameLabel.text = viewModel.cityName
        tourTimeLabel.text = viewModel.numberOfToursAvailable
        subTitle.text = viewModel.cityDescription
        thumbnailImageView.sd_setImage(with: URL(string: viewModel.cityPhoto ?? ""), placeholderImage: nil, options: .refreshCached, completed: nil)
    }
    
    func bindTours(viewModel: Tour) {
        cityNameLabel.text = viewModel.tourName
        tourTimeLabel.text = viewModel.tourTime
        subTitle.text = viewModel.tourDescription
        thumbnailImageView.sd_setImage(with: URL(string: viewModel.tourPhoto ?? ""), placeholderImage: nil, options: .refreshCached, completed: nil)
    }
}

private enum Subviews {
    
    static var shadowView: UIView {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        return view
    }
    
    static var thumbnailImageView: UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }
    
    static var tourTimeLabel: UILabel {
        let tourTime = UILabel()
        tourTime.textAlignment = .center
        tourTime.font = systemThinFont(size: 14)
        return tourTime
    }
    
    static var titleLabel: UILabel {
        let label = UILabel()
        label.font = systemBoldFont(size: 18)
        return label
    }
    
    static var subTitle: UILabel {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = systemThinFont(size: 16)
        return label
    }
}
