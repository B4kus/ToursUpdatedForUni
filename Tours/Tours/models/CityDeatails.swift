//
//  CityDeatails.swift
//  Tours
//
//  Created by Szymon Szysz on 14/12/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

struct CityDetails: Decodable {
    
    // MARK: Properties
    
    let cityList: CitiesList?
    let tour: [String: Tour]?
    
    var tours: [Tour] {
        guard let tour = tour else { return [] }
        return Array(tour.values).sorted(by: { $0.priority ?? 0 < $1.priority ?? 0 })
    }
    
    private enum CodingKeys: String, CodingKey {
        case cityList = "cityList"
        case tour = "tour"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityList = try container.decodeIfPresent(CitiesList.self, forKey: .cityList)
        tour = try container.decodeIfPresent([String: Tour].self, forKey: .tour)
    }
}
