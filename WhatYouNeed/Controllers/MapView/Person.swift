//
//  Person.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation

struct Person {
    var name: String
    var phone: String
    var location: CLLocation?
    var address: String?
    var needs: String
    
    init(name: String, phone: String, needs: String) {
        self.name = name
        self.phone = phone
        self.needs = needs
    }
    
    init(name: String, phone: String, location: CLLocation? = nil, address: String? = nil,  needs: String) {
        self.name = name
        self.phone = phone
        self.location = location
        self.address = address
        self.needs = needs
    }
}
