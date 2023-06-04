//
//  Person.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation

struct Person: Codable {
    let id: String?
    let name: String?
    let phone: String?
    let location: Location?
    let address: String?
    let needs: String?
    
    func copy(id: String? = nil, name: String? = nil, phone: String? = nil, location: Location? = nil,
              address: String? = nil, needs: String? = nil) -> Person {
        return Person(id: id ?? self.id, name: name ?? self.name, phone: phone ?? self.phone,
                      location: location ?? self.location, address: address ?? self.address,
                      needs: needs ?? self.needs)
    }
}

struct Location: Codable {
    let lat: Double?
    let long: Double?
}
