//
//  AddNeedsThreeVC.swift
//  Brian
//
//  Created by James Attersley on 30/08/2023.
//

import UIKit
import RealmSwift

class AddNeedsThreeVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var detailsTF: UITextView!
    
    var profile = Profile()
    var needs = Needs()
    var needsSelected   : [String] = []
    var need            : String = ""
    var titleAdded      : String = ""
    var detailsAdded    : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTF.delegate = self
    }
    
    func addNeedToPet(need: String) {
        
        needsSelected.removeFirst(need)
        
        let realm = try! Realm()
        
        if let exisitingProfile = realm.object(ofType: Profile.self, forPrimaryKey: profile.id) {
            
            let needsList = exisitingProfile.needs
            try! realm.write{
                let newNeeds     = Needs()
                newNeeds.type    = need
                newNeeds.title   = titleAdded
                newNeeds.details = detailsAdded
                
                needsList.append(newNeeds)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

           if text == "\n" {
               textView.resignFirstResponder()
               return false
           }
           return true
       }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if let details = detailsTF.text {
            detailsAdded = details
        }
        addNeedToPet(need: need)
        performSegue(withIdentifier: K.Segue.addNeedsFour, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.addNeedsFour {
            let destinationVC = segue.destination as! AddNeedsFourVC
            
            destinationVC.profile       = self.profile
            destinationVC.needType      = self.need
            destinationVC.needTitle     = self.titleAdded
            destinationVC.needDetails   = self.detailsAdded
            destinationVC.needsSelected = self.needsSelected
        }
    }
}

extension RangeReplaceableCollection where Element: Equatable {
    @discardableResult
    mutating func removeFirst(_ element: Element) -> Element? {
        guard let index = firstIndex(of: element) else { return nil }
        return remove(at: index)
    }
}
