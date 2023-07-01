//
//  Profile.swift
//  Brian
//
//  Created by James Attersley on 30/06/2023.
//

import UIKit

struct Profile {
    
    var id = UUID()
    
    var petName: String
    var petBreed: String
    var petDOB: Date
    
    let formatter = DateFormatter()

    var userPickedImage: UIImage
    
    init(petName: String, petBreed: String, petDOB: Date, userPickedImage: UIImage) {
        self.petName = petName
        self.petBreed = petBreed
        self.petDOB = petDOB
        self.userPickedImage = userPickedImage
        
        formatter.dateFormat = "dd/MM/yyyy"
    }
}
