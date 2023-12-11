//
//  DateFormatter.swift
//  Brian
//
//  Created by James Attersley on 27/07/2023.
//

import UIKit

class UKDate {
    
    func ukDate(dob: Date) -> String {
        
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(from: dob)
    }
}

