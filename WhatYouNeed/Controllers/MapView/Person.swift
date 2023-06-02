//
//  Person.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation

struct Person: Codable {
    let name: String?
    let phone: String?
    let location: Location?
    let address: String?
    let needs: String?
}

struct Location: Codable {
    let lat: Double
    let long: Double
}
