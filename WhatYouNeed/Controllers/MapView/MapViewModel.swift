//
//  MapViewModel.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation
import CoreLocation

class MapViewModel {
    var dummyPins = [
        Person(name: "Alperen Yüksel",
               phone: "+90 545 469 00 05",
               location: CLLocation(latitude: 37.57800853172095, longitude: 36.91264699537522),
               needs: ["Battaniye", "Şarj Aleti", "Erkek İç Çamaşırı", "Ayakkabı 42 Numara", "Pantolon", "Atlet"].joined(separator: ", ")),
        Person(name: "Ali Köse",
               phone: "+90 551 573 63 29",
               location: CLLocation(latitude: 37.57741027154303, longitude: 36.906964213486056),
               needs: ["Diş Fırçası", "Diş Macunu", "Atlet", "Kazak", "Pantolon", "Şarj Aleti", "Kalem", "Defter"].joined(separator: ", ")),
        Person(name: "Şahnur Aslan ",
               phone: "+90 558 848 70 92",
               location: CLLocation(latitude: 37.57157530005541, longitude: 36.9083467409224),
               needs: ["Kalem", "Defter", "İç Çamaşırı", "Atlet", "Mont", "Bot 38 Numara", "Ayakkabı 38 Numara"].joined(separator: ", "))
    ]
    let marasCoordinates = (37.5764759, 36.9112263)
}
