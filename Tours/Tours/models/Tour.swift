//
//  Tour.swift
//  Tours
//
//  Created by Szymon Szysz on 14/12/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

struct Tour: Decodable {
    
    // MARK: Properties
    
    let tourID: String
    let tourDescription: String?
    let tourName: String?
    let tourTime: String?
    let tourPhoto: String?
    let priority: Int?
    
    private enum CodingKeys: String, CodingKey {
        case tourID = "tourID"
        case tourDescription = "tourDescription"
        case tourName = "tourName"
        case tourTime = "tourTime"
        case tourPhoto = "tourPhoto"
        case priority = "priority"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tourID = try container.decode(String.self, forKey: .tourID)
        tourDescription = try container.decodeIfPresent(String.self, forKey: .tourDescription)
        tourName = try container.decodeIfPresent(String.self, forKey: .tourName)
        tourTime = try container.decodeIfPresent(String.self, forKey: .tourTime)
        tourPhoto = try container.decodeIfPresent(String.self, forKey: .tourPhoto)
        priority = try container.decode(Int.self, forKey: .priority)
    }
}
