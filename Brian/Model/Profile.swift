//
//  Profile.swift
//  Brian
//
//  Created by James Attersley on 30/06/2023.
//

import Foundation
import RealmSwift

class Profile: Object {
    
    @Persisted var petName        : String
    @Persisted var petBreed       : String
    @Persisted var petDOB         : String
    @Persisted var profilePhotoURL: String
    @Persisted var needs          : List<Needs>
}
