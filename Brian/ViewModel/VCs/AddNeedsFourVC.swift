//
//  AddNeedsFourVC.swift
//  Brian
//
//  Created by James Attersley on 09/10/2023.
//

import UIKit

class AddNeedsFourVC: UIViewController {
    
    @IBOutlet weak var needTypeLabel    : UILabel!
    @IBOutlet weak var needTitleLabel   : UILabel!
    @IBOutlet weak var needDetailsLabel : UILabel!
    
    var profile       = Profile()
    var needsSelected : [String] = []
    var needType      : String = ""
    var needTitle     : String = ""
    var needDetails   : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        needTypeLabel.text    = needType
        needTitleLabel.text   = needTitle
        needDetailsLabel.text = needDetails
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.addNeedsTwo {
            let destinationVC = segue.destination as! AddNeedsTwoVC
            
            destinationVC.needsSelected = self.needsSelected
            destinationVC.profile       = self.profile
        }
        else if segue.identifier == K.Segue.home {
            let destinationVC = segue.destination as! HomeVC
            
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if needsSelected.count == 0 {
            performSegue(withIdentifier: K.Segue.home, sender: self)
        } else {
            performSegue(withIdentifier: K.Segue.addNeedsTwo, sender: self)
        }
    }
    
    @IBAction func notNowButtonPressed(_ sender: UIButton) {
        
    }
    
}
