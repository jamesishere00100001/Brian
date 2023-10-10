//
//  Constants.swift
//  Brian
//
//  Created by James Attersley on 25/07/2023.
//

import Foundation

struct K {
    
    static let blankCellNib          = "EmptyCell"
    static let blankCell             = "BlankCell"
    static let profileCellNib        = "FilledCell"
    static let profileCell           = "ProfileCell"
    static let needsCollectionVC     = "NeedsCollectionViewCell"
    static let needsCollectionVCNib  = "NeedsCellNib"
    
    struct Segue {
        
        static let addPet         = "addPetSegue"
        static let home           = "showProfileVC"
        static let backHome       = "backToHomeVC"
        static let needs          = "addNeedsSegue"
        static let addNeedsTwo    = "addNeedsTwoSegue"
        static let addNeedsThree  = "addNeedsThreeSegue"
        static let addNeedsFour   = "addNeedsFourSegue"
        static let addMoreNeeds   = "addMoreNeeds"
        static let allNeedsAdded  = "allNeedsAdded"
    }
    
    struct FStore {
        
        static let collectionName    = "profiles"
        static let nameField         = "petName"
        static let breedField        = "petBreed"
        static let dobField          = "petDOB"
        static let imageField        = "userPickedImageURL"
    }
}
