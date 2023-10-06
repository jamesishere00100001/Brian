//
//  AddNeedsThreeVC.swift
//  Brian
//
//  Created by James Attersley on 30/08/2023.
//

import UIKit

class AddNeedsThreeVC: UIViewController {
    
    @IBOutlet weak var detailsTF: UITextField!
    
    var profile = Profile()
    var needsSelected: [String] = []
    var need: String         = ""
    var titleAdded: String   = ""
    var detailsAdded: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addNeedToPet(need: String) {
        
//        switch need {
//        case "Food"         : profile.needs. .food.append([titleAdded: detailsAdded])
//        case "Medicine"     : pet.medicine.append([titleAdded: detailsAdded])
//        case "Vaccination"  : pet.vaccination.append([titleAdded: detailsAdded])
//        case "Grooming"     : pet.grooming.append([titleAdded:detailsAdded])
//        case "Training"     : pet.training.append([titleAdded:detailsAdded])
//        default: break
//        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if let details = detailsTF.text {
            detailsAdded = details
        }
        
        addNeedToPet(need: need)
        print(profile)
        print(need)
        print(titleAdded)
        print(detailsAdded)
    }
    
}
