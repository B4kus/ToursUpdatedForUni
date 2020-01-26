//
//  DetailView.swift
//  Tours
//
//  Created by Szymon Szysz on 28.06.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import UIKit
import MapKit

final class DetailView: UIView {
    
    let mapView: MKMapView = Subviews.mapView
    let dragableContinerView: UIView = Subviews.dragableContinerView
    let routeLabel: UILabel = Subviews.routeLabel
    let infoLabel: UILabel = Subviews.infoLabel
    let topLineDivider: UIView = Subviews.topLineDivider
    let middleLineDivider: UIView = Subviews.middleLineDivider
    let bottomLineDivider: UIView = Subviews.bottomLineDivider
    let startButton: UIButton = Subviews.startButton
    let textViewInfo: UITextView = Subviews.textViewInfo

    init() {
        super.init(frame: .zero)
        setupSelf()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) { assertionFailure(); return nil }
    
    private func setupSelf() {
        backgroundColor = .white
    }
    

    private func setupLayout() {
        
        addSubview(mapView)
        mapView.activate(constraints: mapView.constraints(forEdgeEqualTo: self))
        
        addSubview(dragableContinerView)
        dragableContinerView.activate(constraints: [
            dragableContinerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dragableContinerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dragableContinerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dragableContinerView.heightAnchor.constraint(equalToConstant: 350.0)
        ])

        dragableContinerView.addSubview(routeLabel)
        routeLabel.activate(constraints: [
            routeLabel.topAnchor.constraint(equalTo: dragableContinerView.topAnchor, constant: Layout.Spacing.large),
            routeLabel.leadingAnchor.constraint(equalTo: dragableContinerView.leadingAnchor, constant: Layout.Spacing.large),
            routeLabel.trailingAnchor.constraint(equalTo: dragableContinerView.trailingAnchor, constant: -Layout.Spacing.large)
        ])

        dragableContinerView.addSubview(topLineDivider)
        topLineDivider.activate(constraints: [
            topLineDivider.topAnchor.constraint(equalTo: routeLabel.bottomAnchor, constant: Layout.Spacing.large),
            topLineDivider.leadingAnchor.constraint(equalTo: dragableContinerView.leadingAnchor, constant: Layout.Spacing.large),
            topLineDivider.trailingAnchor.constraint(equalTo: dragableContinerView.trailingAnchor, constant: -Layout.Spacing.large)
        ])

        dragableContinerView.addSubview(infoLabel)
        infoLabel.activate(constraints: [
            infoLabel.topAnchor.constraint(equalTo: topLineDivider.bottomAnchor, constant: Layout.Spacing.large),
            infoLabel.leadingAnchor.constraint(equalTo: dragableContinerView.leadingAnchor, constant: Layout.Spacing.large),
            infoLabel.trailingAnchor.constraint(equalTo: dragableContinerView.trailingAnchor, constant: -Layout.Spacing.large)
        ])

        dragableContinerView.addSubview(middleLineDivider)
        middleLineDivider.activate(constraints: [
            middleLineDivider.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: Layout.Spacing.large),
            middleLineDivider.leadingAnchor.constraint(equalTo: dragableContinerView.leadingAnchor, constant: Layout.Spacing.large),
            middleLineDivider.trailingAnchor.constraint(equalTo: dragableContinerView.trailingAnchor, constant: -Layout.Spacing.large)
        ])

        dragableContinerView.addSubview(bottomLineDivider)
        bottomLineDivider.activate(constraints: [
            bottomLineDivider.topAnchor.constraint(equalTo: middleLineDivider.bottomAnchor, constant: Layout.Spacing.large),
            bottomLineDivider.leadingAnchor.constraint(equalTo: dragableContinerView.leadingAnchor, constant: Layout.Spacing.large),
            bottomLineDivider.trailingAnchor.constraint(equalTo: dragableContinerView.trailingAnchor, constant: -Layout.Spacing.large)
        ])

        dragableContinerView.addSubview(startButton)
        startButton.activate(constraints: [
            startButton.topAnchor.constraint(equalTo: bottomLineDivider.bottomAnchor, constant: Layout.Spacing.large),
            startButton.leadingAnchor.constraint(equalTo: dragableContinerView.leadingAnchor, constant: Layout.Spacing.large),
            startButton.trailingAnchor.constraint(equalTo: dragableContinerView.trailingAnchor, constant: -Layout.Spacing.large)
        ])

        dragableContinerView.addSubview(textViewInfo)
        textViewInfo.activate(constraints: [
            textViewInfo.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: Layout.Spacing.large),
            textViewInfo.leadingAnchor.constraint(equalTo: dragableContinerView.leadingAnchor, constant: Layout.Spacing.large),
            textViewInfo.trailingAnchor.constraint(equalTo: dragableContinerView.trailingAnchor, constant: -Layout.Spacing.large),
            textViewInfo.bottomAnchor.constraint(equalTo: dragableContinerView.bottomAnchor, constant: -Layout.Spacing.large)
        ])
    }
    
    func animation() {
        UIView.animate(withDuration: 0.3) { [weak dragableContinerView] in
            guard let dragableContinerView = dragableContinerView else { return }
            let frame = dragableContinerView.frame
            let yComponent = UIScreen.main.bounds.height - 100
            dragableContinerView.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        }
    }
}

private enum Subviews {
    
    static var mapView: MKMapView {
        let view = MKMapView()
        view.backgroundColor = .red
        return view
    }
    
    static var dragableContinerView: UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }
    
    static var routeLabel: UILabel {
        let label = UILabel()
        label.text = "Route information "
        label.font = systemThinFont
        return label
    }
    
    static var infoLabel: UILabel {
        let label = UILabel()
        label.text = "Duration: 2 hours"
        label.font = systemThinFont
        return label
    }
    
    static var topLineDivider: UIView {
        let view = UIView()
        view.backgroundColor = systemGreyColor
        return view
    }
    
    static var middleLineDivider: UIView {
        let view = UIView()
        view.backgroundColor = systemGreyColor
        return view
    }
    
    static var bottomLineDivider: UIView {
        let view = UIView()
        view.backgroundColor = systemGreyColor
        return view
    }
    
    static var startButton: UIButton {
        let button = UIButton()
        button.backgroundColor = systemBlueColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Let start our tour!", for: .normal)
        return button
    }
    
    static var textViewInfo: UITextView {
        let textView = UITextView()
        textView.text = "If you really enjoy spending your vacation ‘on water’ or would like to try something new and exciting for the first time, then you can consider a houseboat vacation. There are so many fun things to do and so many great landscapes to see on a houseboat vacation! But before making further plans, let’s take a look at sa options that you have for a low-cost vacation on water: you could rent a houseboat this year and try out an altogether exotic kind of vacation this year, or you could indulge in a houseboat timeshare. What is a houseboat timeshare? Most people who have used a houseboat timeshare say that it is a great way to spend your vacation at a very high-quality resort, in a place where you couldn’t get reservations so easily that too at a very low price! Doesn’t that sound great? But let’s see how and why houseboat timeshares can offer you with such fabulous opportunities of low-cost vacationing on water.er exotic kind of vacation this year, or you could indulge in a houseboat timeshare. What is a houseboat timeshare? Most people who have used a houseboat timeshare say that it is a great way to spend your vacation at a very high-quality resort, in a place where you couldn’t get reservations so easily that too at a very low price! Doesn’t that sound great? But let’s see how and why houseboat timeshares can offer you with such fabulous opportunities of low-cost vacationing on water.ing on water.er exotic kind of vacation this year, or you could indulge in a houseboat timeshare. What is a houseboat timeshare? Most people who have used a houseboat timeshare say that it is a great way to spend your vacation at a very high-quality resort, in a place where you couldn’t get reservations so easily that too at a very low price! Doesn’t that sound great? But let’s see how and why houseboat timeshares can offer you with such fabulous opportunities of low-cost vacationing on water."
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.font = systemThinFont
        return textView
    }
}
