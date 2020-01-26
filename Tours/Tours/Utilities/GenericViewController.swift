//
//  GenericViewController.swift
//  Tours
//
//  Created by Szymon Szysz on 14/12/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {
    
    // MARK: - View
    
    private let containerView = SubViews.containerView
    private let activityIndicator = SubViews.activityIndicator
    
    // MARK: - Initalization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        view.addSubview(containerView)
        containerView.activate(constraints: containerView.constraints(forEdgeEqualTo: view))
        
        containerView.addSubview(activityIndicator)
        activityIndicator.activate(constraints: [
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 150.0),
            activityIndicator.heightAnchor.constraint(equalToConstant: 150.0)
        ])
    }
    
    func startActivityIndicator() {
        containerView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        containerView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = systemBlueColor
    }
}

private enum SubViews {
    
    static var containerView: UIView  {
        let view = UIView()
        return view
    }
    
    static var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .yellow
        return activityIndicator
    }
}

