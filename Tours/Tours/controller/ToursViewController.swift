//
//  ToursViewController.swift
//  Tours
//
//  Created by Szymon Szysz on 02.07.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import UIKit

final class ToursViewController: GenericViewController, ViewConfigurable {
    
    //MARK: - Views
    
    typealias ContentViewType = TourView
    
    //MARK: - Managers
    
    private let firebaseDatabaseManager: FirebaseDatabaseManaging
    
    //MARK: - Properties
    
    private let cityID: String
    private var isOpen = false
    private var cityDetails: CityDetails? {
        didSet { updateCollectionView() }
    }
    
    //MARK: - Initialization
    
    init(cityID: String,
         firebaseDatabaseManager: FirebaseDatabaseManaging = FirebaseDatabaseManager()) {
        self.cityID = cityID
        self.firebaseDatabaseManager = firebaseDatabaseManager
        super.init()
    }
    
    required init?(coder: NSCoder) { assertionFailure(); return nil }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTapGestureForPhoto()
    }
    
    override func loadView() {
        super.loadView()
        loadContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        downloadListOfCities()
    }
    
    //MARK: - Setup
    
    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }
    
    private func downloadListOfCities() {
        startActivityIndicator()
        firebaseDatabaseManager.getCityDetails(cityId: cityID) { [weak self] (result) in
            guard let self = self else { return }
            self.cityDetails = result
            self.stopActivityIndicator()
            self.contentView.emptyView.isHidden = !result.tours.isEmpty
        }
    }
    
    private func updateCollectionView() {
        contentView.collectionView.reloadData()
        guard let model = cityDetails?.cityList else { return }
        contentView.bind(model: model)
    }
    
    
    //MARK: - Action
    
    private func addTapGestureForPhoto() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ToursViewController.flip))
        contentView.continerView.addGestureRecognizer(tap)
    }
    
    @objc func flip(recognizer: UITapGestureRecognizer) {
        if isOpen {
            isOpen = false
            contentView.cityPhoto.isHidden = false
            contentView.cityInfo.isHidden = true
            contentView.cityTitle.isHidden = true
            UIView.transition(with: contentView.continerView, duration: 0.4, options: .transitionFlipFromRight, animations: nil, completion: nil)
            navigationController?.navigationBar.tintColor = systemBlueColor
        } else {
            isOpen = true
            navigationController?.navigationBar.tintColor = systemBlueColor
            contentView.cityPhoto.isHidden = true
            contentView.cityInfo.isHidden = false
            contentView.cityTitle.isHidden = false
            UIView.transition(with: contentView.continerView, duration: 0.4, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
}

extension ToursViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tours = cityDetails?.tour?.values.count   else { return 0 }
        return tours
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = cityDetails else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourCollectionViewCell.reuseIdentifier, for: indexPath) as? TourCollectionViewCell else {return UICollectionViewCell() }
        cell.bindTours(viewModel: item.tours[indexPath.row])
        return cell
    }
}

extension ToursViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = cityDetails else { return }
        let tourID: String = item.tours[indexPath.row].tourID
        let detailViewController = DetailViewController(tourID: tourID)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ToursViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * Layout.Spacing.large, height: 250.0)
    }
}
