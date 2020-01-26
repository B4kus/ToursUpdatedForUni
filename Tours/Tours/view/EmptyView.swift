//
//  EmptyView.swift
//  Tours
//
//  Created by Szymon Szysz on 18/01/2020.
//  Copyright © 2020 Szymon Szysz. All rights reserved.
//

import UIKit

final class EmptyView: UIView {
    
    let emptyTextLabel: UILabel = Subviews.emptyLabel
    
    init() {
        super.init(frame: .zero)
        
        setupSelf()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubview(emptyTextLabel)
        emptyTextLabel.activate(constraints: [
            emptyTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.Spacing.large),
            emptyTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.Spacing.large)
        ])
    }
}


private enum Subviews {
    
    static var emptyLabel: UILabel {
        let label = UILabel()
        label.text = "There is no data to display :("
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
}
