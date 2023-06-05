//
//  CurrentUser.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 30.05.2023.
//

import Foundation

class CurrentUser {
    static let shared = ObservableObject<Person>()
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
    static func isPinned() -> Bool {
        let location = CurrentUser.shared.value?.location
        return location?.lat != nil || location?.long != nil
    }
    
    static func isFirstTime() -> Bool {
        return UserDefaults.standard.string(forKey: CurrentUser.CURRENT_USER_KEY) != nil
    }
    
    
    private init() {}
    
    static func set(to user: Person) {
        self.shared.set(value: user)
        
    }
    
    static func setForTheFirstTime(user: Person) {
        set(to: user)
        
    }
    
}
