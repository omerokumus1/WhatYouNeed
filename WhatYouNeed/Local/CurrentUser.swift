//
//  CurrentUser.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 30.05.2023.
//

import Foundation

class CurrentUser {
    static let CURRENT_USER_KEY = "CURRENT_USER_KEY"
    static var currentUserId: String {
        get {
            if let id = UserDefaults.standard.string(forKey: CURRENT_USER_KEY) {
                return id
            }
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: CURRENT_USER_KEY)
            return uuid
        }
    }
    static let shared = ObservableObject(value: Person(id: currentUserId, name: "John Doe", phone: "+90 555 111 22 33", location: nil, address: """
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
                                                      ))
    private init() { }
    
    static func save(currentUser: Person) {
        shared.set(value: currentUser)
        NetworkService.shared.save(currentUser: currentUser)
    }
    
    static func set(user: Person) {
        self.shared.set(value: user)
        NetworkService.shared.save(currentUser: user)
    }
    
}
