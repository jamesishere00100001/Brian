//
//  Needs.swift
//  Brian
//
//  Created by James Attersley on 29/08/2023.
//

import Foundation
import RealmSwift

class Needs: Object {
    
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
    
//    @Persisted var foodList         = List<Food>()
//    @Persisted var medicineList      = List<Medicine>()
//    @Persisted var vaccinationList  = List<Vaccination>()
//    @Persisted var groomingList     = List<Grooming>()
//    @Persisted var trainingList     = List<Training>()
//    @Persisted var otherList        = List<Other>()
//    
//    var parentProfile = LinkingObjects(fromType: Profile.self, property: "needs")
//}
//
//class Food: Object {
//    @Persisted var title   : String = ""
//    @Persisted var details : String = ""
//    var parentProfile = LinkingObjects(fromType: Needs.self, property: "foodList")
//}
//
//class Medicine: Object {
//    @Persisted var title   : String = ""
//    @Persisted var details : String = ""
//    var parentProfile = LinkingObjects(fromType: Needs.self, property: "medicineList")
//}
//
//class Vaccination: Object {
//    @Persisted var title   : String = ""
//    @Persisted var details : String = ""
//    var parentProfile = LinkingObjects(fromType: Needs.self, property: "vaccinationList")
//}
//
//class Grooming: Object {
//    @Persisted var title   : String = ""
//    @Persisted var details : String = ""
//    var parentProfile = LinkingObjects(fromType: Needs.self, property: "groomingList")
//}
//
//class Training: Object {
//    @Persisted var title   : String = ""
//    @Persisted var details : String = ""
//    var parentProfile = LinkingObjects(fromType: Needs.self, property: "trainingList")
//}
//
//class Other: Object {
//    @Persisted var title   : String = ""
//    @Persisted var details : String = ""
//    var parentProfile = LinkingObjects(fromType: Needs.self, property: "otherList")
//}

