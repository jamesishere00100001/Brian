//
//  Constants.swift
//  Brian
//
//  Created by James Attersley on 25/07/2023.
//

import Foundation

struct K {
    
    static let blankCellNib       = "EmptyCell"
    static let blankCell          = "BlankCell"
    static let profileCellNib     = "FilledCell"
    static let profileCell        = "ProfileCell"
    
    struct Segue {
        
        static let addPet         = "addPetSegue"
        static let profiles       = "showProfileVC"
    }
    
    struct FStore {
        
        static let collectionName    = "profiles"
        static let nameField         = "petName"
        static let breedField        = "petBreed"
        static let dobField          = "petDOB"
        static let imageField        = "userPickedImageURL"
    }
}
