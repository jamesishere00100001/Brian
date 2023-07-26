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
    
    func fireStoreSave(petName: String, petBreed: String, petDOB: String, petImage: String) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "Pet Name": petName,
            "Pet Breed": petBreed,
            "DOB": petDOB,
            "Pet Image": petImage]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func fireStoreRead() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
