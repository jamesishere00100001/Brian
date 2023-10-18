//
//  AddNeedsFourVC.swift
//  Brian
//
//  Created by James Attersley on 09/10/2023.
//

import UIKit
import EventKitUI

class AddNeedsFourVC: UIViewController, EKEventEditViewDelegate, UINavigationControllerDelegate {
    
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
    
    func addEventToCalendar() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            let eventStore = EKEventStore()
            if #available(iOS 17.0, *) {
                eventStore.requestFullAccessToEvents { (granted, error) in
                    if granted {
                        print("access granted to calendar at iOS 17 level")
                        DispatchQueue.main.async {
                            self.showEventViewController()
                        }
                    }
                }
            } else {
                eventStore.requestAccess(to: .event) { (granted, error) in
                    if granted {
                        print("access granted to calendar at below iOS 17 level")
                        DispatchQueue.main.async {
                            self.showEventViewController()
                        }
                    }
                }
        }
        case .authorized:
            // do stuff
            DispatchQueue.main.async {
                self.showEventViewController()
            }
        default: print("access not provided to calendar"); break
        }
    }
    
    func showEventViewController() {
        let eventVC              = EKEventEditViewController()
        eventVC.editViewDelegate = self
        eventVC.eventStore       = EKEventStore()
        
        let event       = EKEvent(eventStore: eventVC.eventStore)
        event.title     = self.needTitle
        event.notes     = self.needDetails
        event.startDate = Date()
        eventVC.view.tintColor = UIColor(named: "Text")
        eventVC.event   = event

        present(eventVC, animated: true)
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        dismiss(animated: true, completion: nil)
        needsCompleted()
    }
    
    func needsCompleted() {
        if needsSelected.count == 0 {
            performSegue(withIdentifier: K.Segue.allNeedsAdded, sender: self)
        } else {
            performSegue(withIdentifier: K.Segue.addMoreNeeds, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.addMoreNeeds {
            let destinationVC = segue.destination as! AddNeedsTwoVC
            
            destinationVC.needsSelected = self.needsSelected
            destinationVC.profile       = self.profile
        }
        
//        else if segue.identifier == K.Segue.allNeedsAdded {
//            let destinationVC = segue.destination as! HomeVC
//        }
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
        
        addEventToCalendar()
//        needsCompleted()
    }
    
    @IBAction func notNowButtonPressed(_ sender: UIButton) {
        
        needsCompleted()
    }
}
