//
//  Artworks.swift
//  Tours
//
//  Created by Szymon Szysz on 05.07.2018.
//  Copyright © 2018 Szymon Szysz. All rights reserved.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let identifier: String
    let eventType: EventType
    
    enum EventType: String {
      case onEntry = "On Entry"
      case onExit = "On Exit"
    }
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, eventType: EventType ) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
        self.eventType = eventType
        
        super.init()
    }
    
    init(model: Coordinates) {
        self.title = model.pointName
        self.locationName = model.pointDescription ?? ""
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: model.pointLatitude) ?? 0.0, longitude: CLLocationDegrees(exactly: model.pointLongitude) ?? 0.0)
        self.discipline = model.pointID
        self.radius = 100
        self.identifier = model.pointID
        self.eventType = .onEntry
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}




