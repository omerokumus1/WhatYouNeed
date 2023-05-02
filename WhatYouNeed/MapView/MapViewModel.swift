//
//  MapViewModel.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.05.2023.
//

import Foundation

class MapViewModel {
    let dummyPins = [
        Person(name: "Alperen Yüksel",
               phone: "+90 545 469 00 05",
               coordinate: CGPoint(x: 252.33332824707031, y: 279),
               needs: ["Battaniye", "Şarj Aleti", "Erkek İç Çamaşırı", "Ayakkabı 42 Numara", "Pantolon", "Atlet"]),
        Person(name: "Ali Köse",
               phone: "+90 551 573 63 29",
               coordinate: CGPoint(x: 29, y: 308.66665649414063),
               needs: ["Diş Fırçası", "Diş Macunu", "Atlet", "Kazak", "Pantolon", "Şarj Aleti", "Kalem", "Defter"]),
        Person(name: "Şahnur Aslan ",
               phone: "+90 558 848 70 92",
               coordinate: CGPoint(x: 83.333328247070313, y: 598),
               needs: ["Kalem", "Defter", "İç Çamaşırı", "Atlet", "Mont", "Bot 38 Numara", "Ayakkabı 38 Numara"])
    ]
    let marasCoordinates = (37.5764759, 36.9112263)
}
