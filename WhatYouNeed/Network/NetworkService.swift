//
//  NetworkService.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.06.2023.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    
    
//    func fetchCurrentUser() {
//        // CurrentUser.shared.set(value: )
//    }
//    
    func fetchPins() -> [Person]{
        return [
            Person(id: "1", name: "Alperen Yüksel",
                   phone: "+90 545 469 00 05",
                   location: Location(lat: 37.57800853172095, long: 36.91264699537522), address: "",
                   needs: ["Battaniye", "Şarj Aleti", "Erkek İç Çamaşırı", "Ayakkabı 42 Numara", "Pantolon", "Atlet"].joined(separator: ", ")),
            Person(id:"2", name: "Ali Köse",
                   phone: "+90 551 573 63 29",
                   location: Location(lat: 37.57741027154303, long: 36.906964213486056), address: "",
                   needs: ["Diş Fırçası", "Diş Macunu", "Atlet", "Kazak", "Pantolon", "Şarj Aleti", "Kalem", "Defter"].joined(separator: ", ")),
            Person(id: "3", name: "Şahnur Aslan ",
                   phone: "+90 558 848 70 92",
                   location: Location(lat: 37.57157530005541, long: 36.9083467409224), address: "",
                   needs: ["Kalem", "Defter", "İç Çamaşırı", "Atlet", "Mont", "Bot 38 Numara", "Ayakkabı 38 Numara"].joined(separator: ", "))
        ]
    }
    
    
    func save(currentUser: Person) {
        
    }
    
}
