//
//  Person.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation

struct Person {
    let name: String
    let phone: String
    let location: CLLocation
    let needs: [String]
}
