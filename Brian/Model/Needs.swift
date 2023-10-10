//
//  Needs.swift
//  Brian
//
//  Created by James Attersley on 29/08/2023.
//

import Foundation
import RealmSwift

class Needs: Object {
    
    @Persisted var type    : String = ""
    @Persisted var title   : String = ""
    @Persisted var details : String = ""
    var parentProfile = LinkingObjects(fromType: Needs.self, property: "medicineList")
    
    let needsLabels: [String]       = ["Food",
                                       "Medicine",
                                       "Vaccination",
                                       "Grooming",
                                       "Training",
                                       "Other"]
}
