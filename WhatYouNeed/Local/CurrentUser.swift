//
//  CurrentUser.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 30.05.2023.
//

import Foundation

class CurrentUser {
    static var shared = Person(name: "John Doe", phone: "+90 555 111 22 33", location: nil, address: """
                    8 Jockey Hollow Dr.
                    Georgetown, SC 29440
                    """, needs:
        """
    Need 1
    Need 2
    Need 3
    Need 4
    Need 5
    Need 6
    Need 7
    Need 8
"""
    )
    private init() { }
    
}
