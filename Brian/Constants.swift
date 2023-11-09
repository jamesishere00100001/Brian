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
    static let needsListNib          = "ListCell"
    static let needsListCell         = "NeedsListCell"
    static let needsCollectionVC     = "NeedsCollectionViewCell"
    static let needsCollectionVCNib  = "NeedsCellNib"
    static let headerCellNib         = "HeaderCellNib"
    static let headerCell            = "HeaderCell"
    static let shareHeaderNib        = "ShareHeaderNib"
    static let shareHeaderCell       = "ShareHeaderCell"
    static let shareNeedsNib         = "ShareNeedsNib"
    static let shareNeedsCell        = "ShareNeedsCell"
    
    struct Segue {
        
        static let addPet            = "addPetSegue"
        static let home              = "showProfileVC"
        static let backHome          = "backToHomeVC"
        static let needs             = "addNeedsSegue"
        static let addNeedsTwo       = "addNeedsTwoSegue"
        static let addNeedsThree     = "addNeedsThreeSegue"
        static let addNeedsFour      = "addNeedsFourSegue"
        static let addMoreNeeds      = "addMoreNeeds"
        static let allNeedsAdded     = "allNeedsAdded"
        static let needsList         = "needsListSegue"
        static let newNeeds          = "addNewNeeds"
        static let returnHome        = "returnToHomeVC"
        static let about             = "showAboutVC"
        static let editNeed          = "editNeed"
        static let cancelHome        = "cancelToHomeVC"
        static let editPet           = "editPet"
        static let shareSheet        = "shareSheet"
    }
}
