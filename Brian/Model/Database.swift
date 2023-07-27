//
//  Database.swift
//  Brian
//
//  Created by James Attersley on 01/07/2023.
//

import Foundation
import FirebaseFirestore

struct Database {
    
    //MARK: - Firestore database save and read functions
    
    let db = Firestore.firestore()
    
    func fireStoreSave(profile: Profile) {
    
            db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.nameField: profile.petName,
            K.FStore.breedField: profile.petBreed,
            K.FStore.dobField: profile.petDOB,
            K.FStore.imageField: profile.profilePhotoURL]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added.")
            }
        }
    }
    
    func fireStoreRead() {
        db.collection(K.FStore.collectionName).getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

