//
//  Needs.swift
//  Brian
//
//  Created by James Attersley on 29/08/2023.
//

import Foundation
import RealmSwift

class Needs: Object {
    
let needsLabels: [String] = ["Food",
                             "Medical",
                             "Vaccination",
                             "Grooming",
                             "Training",
                             "Other"]
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    
    @Persisted var type    : String = ""
    @Persisted var title   : String = ""
    @Persisted var details : String = ""
    
    @Persisted(originProperty: "needs") var assignee: LinkingObjects<Profile>
}
