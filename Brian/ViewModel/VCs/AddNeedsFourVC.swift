//
//  AddNeedsFourVC.swift
//  Brian
//
//  Created by James Attersley on 09/10/2023.
//

import UIKit
import EventKitUI
import RealmSwift

class AddNeedsFourVC: UIViewController, EKEventEditViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textView         : UIView!
    @IBOutlet weak var needTypeLabel    : UILabel!
    @IBOutlet weak var needTitleLabel   : UILabel!
    @IBOutlet weak var needDetailsLabel : UILabel!
    
    var profile       = Profile()
    var needs         = Needs()
    var needSelected  : String   = "need"
    var needType      : String   = ""
    var needTitle     : String   = ""
    var needDetails   : String   = ""
    var editingNeed   : Bool     = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        needTypeLabel.text    = needType
        needTitleLabel.text   = needTitle
        needDetailsLabel.text = needDetails
        
        textView.layer.cornerRadius = 8
    }
    
    //MARK: - EventKit methods
    
    func addEventToCalendar() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined, .denied, .restricted:
            let eventStore = EKEventStore()
            if #available(iOS 17.0, *) {
                eventStore.requestFullAccessToEvents { (granted, error) in
                    if granted {
                        DispatchQueue.main.async {
                            self.showEventViewController()
                        }
                    }
                }
            } else {
                eventStore.requestAccess(to: .event) { (granted, error) in
                    if granted {
                        DispatchQueue.main.async {
                            self.showEventViewController()
                        }
                    }
                }
        }
        case .authorized:
            DispatchQueue.main.async {
                self.showEventViewController()
            }
            
        default:
            let alert = UIAlertController(title: "No access", message: "Access has not been allowed to view your photos.\n\n Please check your setting and try again.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okButton)
            
            present(alert, animated: true)
        }
    }
    
    func showEventViewController() {
        let eventVC              = EKEventEditViewController()
        eventVC.editViewDelegate = self
        eventVC.eventStore       = EKEventStore()
        
        let event                = EKEvent(eventStore: eventVC.eventStore)
        event.title              = self.needTitle
        event.notes              = self.needDetails
        event.startDate          = Date()
        eventVC.view.tintColor   = .black
        eventVC.event            = event

        present(eventVC, animated: true)
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        dismiss(animated: true, completion: nil)
        needsCompleted()
    }
    
    func needsCompleted() {
        if needSelected.count == 0 {
            performSegue(withIdentifier: K.Segue.allNeedsAdded, sender: self)
        } else {
            performSegue(withIdentifier: K.Segue.addMoreNeeds, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.addMoreNeeds {
            let destinationVC = segue.destination as! AddNeedsTwoVC
            
            destinationVC.needSelected  = self.needSelected
            destinationVC.profile       = self.profile
        }
    }
    
    func addNeedToPet(need: String) {
        
        if editingNeed == false {
            
        let realm = try! Realm()
        
        if let exisitingProfile = realm.object(ofType: Profile.self, forPrimaryKey: self.profile.id) {
            
            let needsList = exisitingProfile.needs
            try! realm.write{
                let newNeeds     = Needs()
                newNeeds.type    = need
                newNeeds.title   = self.needTitle
                newNeeds.details = self.needDetails
                needsList.append(newNeeds)
            }
        }
            
        } else if editingNeed == true {
            let realm = try! Realm()
                                 
            if realm.object(ofType: Needs.self, forPrimaryKey: needs.id) != nil {
                try! realm.write {
                    let editedNeed = Needs(value: ["id"     : needs.id,
                                                   "type"   : need,
                                                   "title"  : needTitle,
                                                   "details": needDetails])
                    
                    realm.add(editedNeed, update: .modified)
                }
            }
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        addNeedToPet(need: needType)
        performSegue(withIdentifier: K.Segue.allNeedsAdded, sender: self)
//        needsCompleted()
    }
    
    @IBAction func setReminderPressed(_ sender: UIButton) {
        
        addEventToCalendar()
        performSegue(withIdentifier: K.Segue.allNeedsAdded, sender: self)
//        needsCompleted()
    }
}
