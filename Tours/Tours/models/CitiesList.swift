//
//  CitiesList.swift
//  Tours
//
//  Created by Szymon Szysz on 03/12/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

import UIKit
import Firebase

struct CitiesList: Decodable {
    
    // MARK: Properties
    
    let cityID: String
    let cityName: String?
    let cityDescription: String?
    let numberOfToursAvailable: String?
    let cityPhoto: String?
    let priority: Int?
    
    private enum CodingKeys: String, CodingKey {
        case cityID = "cityID"
        case cityName = "cityName"
        case cityDescription = "cityDescription"
        case numberOfToursAvailable = "numberOfToursAvailable"
        case cityPhoto = "cityPhoto"
        case priority = "priority"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityID = try container.decode(String.self, forKey: .cityID)
        cityName = try container.decodeIfPresent(String.self, forKey: .cityName)
        cityDescription = try container.decodeIfPresent(String.self, forKey: .cityDescription)
        numberOfToursAvailable = try container.decodeIfPresent(String.self, forKey: .numberOfToursAvailable)
        cityPhoto = try container.decodeIfPresent(String.self, forKey: .cityPhoto)
        priority = try container.decode(Int.self, forKey: .priority)
    }
}
