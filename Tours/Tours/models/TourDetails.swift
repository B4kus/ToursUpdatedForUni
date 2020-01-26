//
//  TourDetails.swift
//  Tours
//
//  Created by Szymon Szysz on 14/01/2020.
//  Copyright © 2020 Szymon Szysz. All rights reserved.
//

import Foundation

struct TourDetails: Decodable {
    
    // MARK: Properties
    
    let tour: Tour?
    let coordinates: [String: Coordinates]?
    
    var coordinatesList: [Coordinates] {
        guard let coordinates = coordinates else { return [] }
        return Array(coordinates.values).sorted(by: {$0.priority ?? 0 < $1.priority ?? 0})
    }
    
    private enum CodingKeys: String, CodingKey {
        case tour = "tour"
        case coordinates = "coordinates"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tour = try container.decodeIfPresent(Tour.self, forKey: .tour)
        coordinates = try container.decodeIfPresent([String: Coordinates].self, forKey: .coordinates)
    }
}

struct Coordinates: Decodable, Encodable {
    
    // MARK: Properties
    
    let pointDescription: String?
    let pointID: String
    let pointLatitude: Float
    let pointLongitude: Float
    let pointName: String?
    let priority: Int?
    
    private enum CodingKeys: String, CodingKey {
        case pointDescription = "pointDescription"
        case pointID = "pointID"
        case pointLatitude = "pointLatitude"
        case pointLongitude = "pointLongitude"
        case pointName = "pointName"
        case priority = "priority"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pointDescription = try container.decodeIfPresent(String.self, forKey: .pointDescription)
        pointID = try container.decode(String.self, forKey: .pointID)
        pointLatitude = try container.decode(Float.self, forKey: .pointLatitude)
        pointLongitude = try container.decode(Float.self, forKey: .pointLongitude)
        pointName = try container.decodeIfPresent(String.self, forKey: .pointName)
        priority = try container.decode(Int.self, forKey: .priority)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pointLatitude, forKey: .pointLatitude)
        try container.encode(pointLongitude, forKey: .pointLongitude)
        try container.encode(pointID, forKey: .pointID)
        try container.encode(pointName, forKey: .pointName)
        try container.encode(priority, forKey: .priority)
    }
}

struct PreferencesKeys {
    static let savedItems = "savedItems"
}

extension Artwork {
    public class func allGeotifications() -> [Coordinates] {
        guard let savedData = UserDefaults.standard.data(forKey: PreferencesKeys.savedItems) else { return [] }
        let decoder = JSONDecoder()
        if let savedGeotifications = try? decoder.decode(Array.self, from: savedData) as [Coordinates] {
            return savedGeotifications
        }
        return []
    }
}
