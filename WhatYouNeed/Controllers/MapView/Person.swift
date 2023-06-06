//
//  Person.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct Person: Codable {
    let id: String?
    let name: String?
    let phone: String?
    let location: Location?
    let address: String?
    let needs: String?
    
    init(id: String?, name: String?, phone: String?, location: Location?, address: String?, needs: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.location = location
        self.address = address
        self.needs = needs
    }
    
    init(id: String) {
        self.id = id
        self.name = nil
        self.phone = nil
        self.location = nil
        self.address = nil
        self.needs = nil
    }
    
    func copyWith(id: String? = nil, name: String? = nil, phone: String? = nil, location: Location? = nil,
              address: String? = nil, needs: String? = nil) -> Person {
        return Person(id: id ?? self.id, name: name ?? self.name, phone: phone ?? self.phone,
                      location: location ?? self.location, address: address ?? self.address,
                      needs: needs ?? self.needs)
    }
        
    
    func toDict() -> [String: Any] {
        return [
            "id": self.id ?? "",
            "name": self.name ?? "",
            "phone": self.phone ?? "",
            "location": ["lat": self.location?.lat, "long": self.location?.long],
            "address": self.address ?? "",
            "needs": self.needs ?? ""
        ]
    }
    
    static func createFrom(queryDocumentSnapshot: QueryDocumentSnapshot) -> Person {
        let data = queryDocumentSnapshot.data()
        let locationData = data["location"] as? [String: Double]
        let location = Location(lat: locationData?["lat"], long: locationData?["long"])
        return Person(id: data["id"] as? String, name: data["name"] as? String, phone: data["phone"] as? String,
                      location: location, address: data["address"] as? String, needs: data["needs"] as? String)
    }
}

struct Location: Codable {
    let lat: Double?
    let long: Double?
}
