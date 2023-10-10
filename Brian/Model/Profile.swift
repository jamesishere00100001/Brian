//
//  Profile.swift
//  Brian
//
//  Created by James Attersley on 30/06/2023.
//

import Foundation
import RealmSwift
import UIKit

class Profile: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    
    @Persisted var petName        : String = ""
    @Persisted var petBreed       : String = ""
    @Persisted var petDOB         : String = ""
    @Persisted var profilePhotoURL: String = ""
    @Persisted var needs          = List<Needs>()
    
    var profileImage              = UIImage()
}
