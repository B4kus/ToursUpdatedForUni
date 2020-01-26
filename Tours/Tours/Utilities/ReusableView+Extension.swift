//
//  ReusableView+Extension.swift
//  Tours
//
//  Created by Szymon Szysz on 20/10/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

import UIKit
import MapKit

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionReusableView: ReuseIdentifying {}


extension MKMapView {
  func zoomToUserLocation() {
    guard let coordinate = userLocation.location?.coordinate else { return }
    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    setRegion(region, animated: true)
  }
}
