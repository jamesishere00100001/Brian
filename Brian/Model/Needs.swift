//
//  Needs.swift
//  Brian
//
//  Created by James Attersley on 29/08/2023.
//

import Foundation

struct Needs {
    
    let needs: [String]             = ["Food",
                                       "Medicine",
                                       "Vaccination",
                                       "Grooming",
                                       "Training",
                                       "Other"]
    
    var otherItems: [String]        = []
    
    struct NeedsItems {
        
        var food                        = ""
        var medicine                    = ""
        var vaccination                 = ""
        var grooming                    = ""
        var training                    = ""
        var otherNeeds: [String:String] = [:]
    }
}
