//
//  FirebaseManager.swift
//  Tours
//
//  Created by Szymon Szysz on 06/12/2019.
//  Copyright © 2019 Szymon Szysz. All rights reserved.
//

import Firebase
import FirebaseDatabase

typealias JSONDictionary = [String: Any]

protocol FirebaseDatabaseManaging {
    func getCitiesList(complitionBlock: @escaping ([CitiesList]) -> Void)
    func getCityDetails(cityId: String, complitionBlock: @escaping (CityDetails) -> Void)
    func getTourDetails(tourId: String, complitionBlock: @escaping (TourDetails) -> Void)
}

final class FirebaseDatabaseManager: FirebaseDatabaseManaging {
    
    private let database: DatabaseReference
    private var version: String = "City"
    
    private enum Node {
        case citiesList
        case cityDetails
        case tourDetails
    }
    
    private func getReference(_ node: FirebaseDatabaseManager.Node) -> DatabaseReference {
        switch node {
        case .citiesList: return database.child("cities")
        case .cityDetails: return database.child("tours")
        case .tourDetails: return database.child("toursDetails")
        }
    }
    
    private func getJSONDictionary<T: Encodable>(_ item: T) -> [String: Any?]? {
        guard let jsonData = try? JSONEncoder().encode(item) else { return nil }
        return (try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)) as? [String: Any]
    }
    
    private func getObjectFromJson<T: Decodable>(_ data: JSONDictionary) -> T? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else { return nil }
        do {
            let item = try JSONDecoder().decode(T.self, from: jsonData)
            return item
        } catch(let error) {
            print(error)
            return nil
        }
    }
    
    init() {
        database = Database.database().reference().child(version)
    }
    
    func getCitiesList(complitionBlock: @escaping ([CitiesList]) -> Void) {
        getReference(.citiesList).observeSingleEvent(of: .value) { snapshot in
            guard let list = snapshot.value as? JSONDictionary else { return }
            let citylist = list.keys.compactMap { element -> CitiesList? in
                guard let listJson = list[element] as? JSONDictionary else { return nil }
                guard let list: CitiesList = self.getObjectFromJson(listJson) else { return nil }
                return list
            }
            complitionBlock(citylist)
        }
    }
    
    func getCityDetails(cityId: String, complitionBlock: @escaping (CityDetails) -> Void) {
        getReference(.cityDetails).child(cityId).observeSingleEvent(of: .value) { snapshot in
            guard let item = snapshot.value as? JSONDictionary else { return }
            guard let list: CityDetails = self.getObjectFromJson(item) else { return }
            complitionBlock(list)
        }
    }
    
    func getTourDetails(tourId: String, complitionBlock: @escaping (TourDetails) -> Void) {
        getReference(.tourDetails).child(tourId).observeSingleEvent(of: .value) { snapshot in
            guard let item = snapshot.value as? JSONDictionary else { return }
            guard let list: TourDetails = self.getObjectFromJson(item) else { return }
            complitionBlock(list)
        }
    }
}
