//
//  AddNeedsTwoVC.swift
//  Brian
//
//  Created by James Attersley on 30/08/2023.
//

import UIKit

class AddNeedsTwoVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var needLabel: UILabel!
    @IBOutlet weak var titleTF: UITextField!
    
    var profile      = Profile()
    var needsSelected: [String] = []
    var need         : String = ""
    var titleAdded   : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNeedTitle(needArray: needsSelected)
        
        titleTF.delegate = self
    }
    
    func addNeedTitle(needArray: [String]) {
        
        if let currentNeed = needsSelected.first {
            needLabel.text = "Add the \(currentNeed.lowercased()) title"
            need           = currentNeed
        }
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
            destinationVC.needsSelected = self.needsSelected
            destinationVC.profile       = self.profile
        }
    }
}

