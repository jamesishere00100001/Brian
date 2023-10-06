//
//  Needs.swift
//  Brian
//
//  Created by James Attersley on 29/08/2023.
//

import Foundation
import RealmSwift

class Needs: Object {
    
    let needsLabels: [String]       = ["Food",
                                       "Medicine",
                                       "Vaccination",
                                       "Grooming",
                                       "Training",
                                       "Other"]
    
    @Persisted var foodList         = List<Food>()
    @Persisted var medicieList      = List<Medicine>()
    @Persisted var vaccinationList  = List<Vaccination>()
    @Persisted var groomingList     = List<Grooming>()
    @Persisted var trainingList     = List<Training>()
    @Persisted var otherList        = List<Other>()
    
    
    var parentProfile = LinkingObjects(fromType: Profile.self, property: "needs")
//
//    var food       : [[String : String]] = []
//    var medicine   : [[String : String]] = []
//    var vaccination: [[String : String]] = []
//    var grooming   : [[String : String]] = []
//    var training   : [[String : String]] = []
//    var other      : [[String : String]] = []
    
    
}

class Food: Object {
    var key   = List<String>()
    var value = List<String>()
}

class Medicine: Object {
    var key   = List<String>()
    var value = List<String>()
}

class Vaccination: Object {
    var key   = List<String>()
    var value = List<String>()
}

class Grooming: Object {
    var key   = List<String>()
    var value = List<String>()
}

class Training: Object {
    var key   = List<String>()
    var value = List<String>()
}

class Other: Object {
    var key   = List<String>()
    var value = List<String>()
}

