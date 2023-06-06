//
//  NetworkService.swift
//  WhatYouNeed
//
//  Created by Ömer Faruk Okumuş on 2.06.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


class NetworkService {
    static let shared = NetworkService()
    private let db = Firestore.firestore()
    
    private init() {
        observeCurrentUser()
    }
    
    func fetchPins(completion: @escaping (QuerySnapshot?) -> (Void)) {
        db.collection(FireStoreConstants.pinCollectionName).addSnapshotListener { querySnapshot, error in
            if let e = error {
                print("failed fetching pins: \(e)")
            } else {
                completion(querySnapshot)
            }
        }
    }
    
    func addDummyPins() {
        let collection = db.collection(FireStoreConstants.pinCollectionName)
        fetchDummyPins().forEach { person in
            collection.addDocument(data: person.toDict())
        }
        
    }
    
    private func fetchDummyPins() -> [Person]{
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
    
    func saveOrUpdate(currentUser: Person, to collectionName: String) {
        db.collection(collectionName)
            .whereField("id", isEqualTo: CurrentUser.currentUserId)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("error while updating current user: \(error)")
                } else if querySnapshot?.documents.isEmpty != true { // update current user
                    querySnapshot!.documents.first?.reference.updateData(currentUser.toDict())
                    print("current user is updated in \(collectionName) ")
                } else if querySnapshot?.documents.isEmpty == true { // post current user to people collection first time
                    self.db.collection(collectionName).addDocument(data: currentUser.toDict())
                    print("current user is posted for the first time")
                }
                
            }
    }
    
    func handleCurrentUserFirstTimeLaunching() {
        db.collection(FireStoreConstants.personCollectionName)
            .whereField("id", isEqualTo: CurrentUser.currentUserId)
            .getDocuments { querySnapshot, error in
                if let e = error {
                    print("Error while posting current user for the first time: \(e)")
                } else if querySnapshot?.documents.isEmpty == true {
                    CurrentUser.setForTheFirstTime(user: Person(id: CurrentUser.currentUserId))
                } else if querySnapshot?.documents.first != nil {
                    CurrentUser.set(to: Person.createFrom(queryDocumentSnapshot: (querySnapshot?.documents.first!)!))
                }
                
            }
    }
    
    func observeCurrentUser() {
        CurrentUser.shared.observeBy { currentUser in
            NetworkService.shared.saveOrUpdate(currentUser: currentUser, to: FireStoreConstants.personCollectionName)
            if CurrentUser.isPinned() {
                NetworkService.shared.saveOrUpdate(currentUser: currentUser, to: FireStoreConstants.pinCollectionName)
            } else {
                self.db.collection(FireStoreConstants.pinCollectionName)
                    .whereField("id", isEqualTo: CurrentUser.currentUserId)
                    .getDocuments { querySnapshot, error in
                        if let e = error {
                            print("error removing pin from firebase: \(e)")
                        } else if querySnapshot?.documents.first != nil {
                            querySnapshot?.documents.first?.reference.delete(completion: { error in
                                if let e = error {
                                    print("error while removing document: \(e)")
                                } else {
                                    print("document is removed successfully: \(querySnapshot?.documents.first?.reference)")
                                }
                            })
                        }
                        
                    }
            }
        }
    }
}

class FireStoreConstants {
    static let personCollectionName = "people"
    static let pinCollectionName = "pins"
    
    private init() {}
    
}
