//
//  MapViewModel.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class MapViewModel {
    var pins = ObservableObject<[Person]>()
    var pinToRemove: Person? = nil
    let marasCoordinates = (37.5764759, 36.9112263)
    
    init() {
        observeCurrentUser()
    }
    
    func fetchPins() {
        NetworkService.shared.fetchPins { querySnapshot in
            let pins = querySnapshot?.documents.map({ qds in
                Person.createFrom(queryDocumentSnapshot: qds)
            })
            if let pins = pins { self.pins.set(value: pins) }
            
        }
    }
 
    private func observeCurrentUser() {
        CurrentUser.shared.observeBy { currentUser in
            let currentUserIndex = self.pins.value?.firstIndex(where: { person in
                person.id == currentUser.id
            })
            if currentUserIndex != nil && CurrentUser.isPinned() { // update current user pin
                self.pins.value?.remove(at: currentUserIndex!)
                self.pins.value?.append(currentUser)
            } else if currentUserIndex == nil && CurrentUser.isPinned() { // add current user for the first time
                self.pins.value?.append(currentUser)
            } else if currentUserIndex != nil && !CurrentUser.isPinned() { // remove current user pin
                self.pinToRemove = self.pins.value?[currentUserIndex!]
                self.pins.value?.remove(at: currentUserIndex!)
            }
            self.pins.notifyObservers()
                
        }
    }
}
