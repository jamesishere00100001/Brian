//
//  AddNeedsTwoVC.swift
//  Brian
//
//  Created by James Attersley on 30/08/2023.
//

import UIKit

class AddNeedsTwoVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var needLabel: UILabel!
    @IBOutlet weak var titleTF  : UITextField!
    
    var profile      = Profile()
    var needs        = Needs()
    var needSelected : String   = "need"
    var need         : String   = ""
    var titleAdded   : String   = ""
    var editDetails  : String   = ""
    var editingNeed  : Bool     = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        needLabel.text = "Add the \(self.needSelected.lowercased()) title"
        titleTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: - Next button pressed action and segue
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if let t = titleTF.text {
            titleAdded = t
        }
        
        performSegue(withIdentifier: K.Segue.addNeedsThree, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == K.Segue.addNeedsThree {
            let destinationVC = segue.destination as! AddNeedsThreeVC
            
            destinationVC.need          = self.need
            destinationVC.titleAdded    = self.titleAdded
            destinationVC.needs         = self.needs
            destinationVC.needSelected  = self.needSelected
            destinationVC.profile       = self.profile
            destinationVC.detailsAdded  = self.editDetails
            destinationVC.editingNeed   = self.editingNeed
        }
    }
}

