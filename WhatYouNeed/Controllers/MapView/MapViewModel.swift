//
//  MapViewModel.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation

class MapViewModel {
    var people = ObservableObject<[Person]>()
    let marasCoordinates = (37.5764759, 36.9112263)
    
    func fetchPeople() {
        people.set(value: NetworkService.shared.fetchPins())
    }
}
