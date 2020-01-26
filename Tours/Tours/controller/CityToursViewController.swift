//
//  CityToursViewController.swift
//  Tours
//
//  Created by Szymon Szysz on 17.06.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import UIKit
import AVKit

final class CityToursViewController: GenericViewController, ViewConfigurable {
    
    //MARK: - Views
    
    typealias ContentViewType = CityToursView
    
    //MARK: - Managers
    
    private let firebaseDatabaseManager: FirebaseDatabaseManaging
    
    //MARK: - Properties
    
    private var listOfCities: [CitiesList]? {
        didSet { updateCollectionView() }
    }
    
    //MARK: - Initialization
    
    init(firebaseDatabaseManager: FirebaseDatabaseManaging = FirebaseDatabaseManager()) {
        self.firebaseDatabaseManager = firebaseDatabaseManager
        super.init()
    }
    
    required init?(coder: NSCoder) { assertionFailure(); return nil }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNaviagtionTitle()
        navigationItem.setRightBarButton(.init(barButtonSystemItem: .action, target: self, action: #selector(showTutorialVideo)), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        downloadListOfCities()
    }
    
    override func loadView() {
        super.loadView()
        loadContentView()
    }
    
    //MARK: - Setup
    
    private func setupNaviagtionTitle() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - (view.frame.width / 14), height: view.frame.height))
        titleLabel.text = "Tours"
        titleLabel.textColor = .black
        titleLabel.font = systemBoldFont(size: 32)
        navigationItem.titleView = titleLabel
    }
    
    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }
    
    private func downloadListOfCities() {
        startActivityIndicator()
        firebaseDatabaseManager.getCitiesList() { [weak self] (result) in
            guard let self = self else { return }
            let sortedResult: [CitiesList] = result.sorted(by: { $0.priority ?? 0 < $1.priority ?? 0 })
            self.listOfCities = sortedResult
            self.stopActivityIndicator()
        }
    }
    
    private func updateCollectionView() {
        contentView.collectionView.reloadData()
    }
    
    @objc func showTutorialVideo() {
        let path = Bundle.main.path(forResource: "NatureBeautifulshortvideo720pHD", ofType: "mp4")
        let videoURL = URL(fileURLWithPath: path ?? "")
        
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
}

extension CityToursViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let listOfCities = listOfCities else { return 0 }
        return listOfCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = listOfCities else { return  UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourCollectionViewCell.reuseIdentifier, for: indexPath) as? TourCollectionViewCell else { return UICollectionViewCell() }
        cell.bind(viewModel: item[indexPath.row])
        return cell
    }
}

extension CityToursViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let listOfCities = listOfCities else { return }
        let cityID: String = listOfCities[indexPath.row].cityID
        let toursViewController = ToursViewController(cityID: cityID)
        navigationController?.pushViewController(toursViewController, animated: true)
    }
}

extension CityToursViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 2 * Layout.Spacing.large, height: 300.0)
    }
}
