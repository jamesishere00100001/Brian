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
    
    var profile         = Profile()
    var needs           = Needs()
    var needSelected    : String   = "need"
    var need            : String   = ""
    var titleAdded      : String   = ""
    var detailsAdded    : String   = ""
    var editingNeed     : Bool     = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTF.delegate           = self
        detailsTF.layer.cornerRadius = 8
        detailsTF.text               = detailsAdded
    }
    
    func addNeedToPet(need: String) {
        
        if editingNeed == false {
            
//            for toAdd in needsSelected {
//                if toAdd == need {
//                    let alert = UIAlertController(title: "Duplicate need", message: "Need \(toAdd) already exists, do you wish to save anyway?" , preferredStyle: .alert)
//                    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//                        self.performSegue(withIdentifier: K.Segue.cancelHome, sender: self)
//                    }
//                    
//                    let save = UIAlertAction(title: "Save", style: .default) { (action) in
                        let realm = try! Realm()
                        
                        if let exisitingProfile = realm.object(ofType: Profile.self, forPrimaryKey: self.profile.id) {
                            
                            let needsList = exisitingProfile.needs
                            try! realm.write{
                                let newNeeds     = Needs()
                                newNeeds.type    = need
                                newNeeds.title   = self.titleAdded
                                newNeeds.details = self.detailsAdded
                                
                                needsList.append(newNeeds)
                            }
                        }
//                        self.performSegue(withIdentifier: K.Segue.addNeedsFour, sender: self)
//                        self.needsSelected.removeFirst(need)
//                    }
                    
//                    alert.addAction(cancel)
//                    alert.addAction(save)
//                    
//                    present(alert, animated: true)
//                }
//            }
            
        } else if editingNeed == true {
            let realm = try! Realm()
                                 
            if realm.object(ofType: Needs.self, forPrimaryKey: needs.id) != nil {
                try! realm.write {
                    let editedNeed = Needs(value: ["id"     : needs.id,
                                                   "type"   : need,
                                                   "title"  : titleAdded,
                                                   "details": detailsAdded])
                    
                    realm.add(editedNeed, update: .modified)
                }
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
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if let details = detailsTF.text {
            detailsAdded = details
        }
//        needsSelected.removeFirst(need)
//        addNeedToPet(need: need)
        performSegue(withIdentifier: K.Segue.addNeedsFour, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.addNeedsFour {
            let destinationVC = segue.destination as! AddNeedsFourVC
            
            destinationVC.profile       = self.profile
            destinationVC.needType      = self.need
            destinationVC.needTitle     = self.titleAdded
            destinationVC.needDetails   = self.detailsAdded
            destinationVC.needSelected  = self.needSelected
            destinationVC.needs         = self.needs
            destinationVC.editingNeed   = self.editingNeed
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
