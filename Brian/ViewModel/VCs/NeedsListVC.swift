//
//  NeedsListVC.swift
//  Brian
//
//  Created by James Attersley on 16/10/2023.
//

import UIKit
import RealmSwift

class NeedsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var profile = Profile()
    let realm   = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let menuHandler: UIActionHandler = { (action) in
            if action.title == NSLocalizedString("Add need", comment: "") {
                //                performSegue(withIdentifier: K.Segue.needsList, sender: self)
                
                
                //                if let indexPath = self.indexPath {
                //                    print("Menu button pressed inside ProfileCell")
                //                    self.menuDelegate?.profileMenuPressed(menuRequest: K.Segue.needsList)
                //                    self.menuDelegate?.passIndex(index: indexPath)
                //                }
                //need to add delegate to pass UIMenu segue request to HomeVC
                
            } else if action.title == NSLocalizedString("Share all needs", comment: "") {
                
            } else if action.title == NSLocalizedString("Edit", comment: "") {
                
            } else if action.title == NSLocalizedString("Delete pet", comment: "") {
                // Delete action
            }
        }
        
        let menu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Add need", comment: ""), image: UIImage(systemName: "plus"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Share all needs", comment: ""), image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Edit", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Delete pet", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)
        ])
        
        menuButton.menu = menu
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.headerCell, bundle: nil), forCellReuseIdentifier: K.headerCellNib)
        tableView.register(UINib(nibName: K.needsListCell, bundle: nil), forCellReuseIdentifier: K.needsListNib)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2  // You have two sections: section 0 and section 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            print("Section case 0 is triggered")
            return 1
            
        case 1:
            print("Section case 1 is triggered")
            return profile.needs.count
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: K.headerCellNib, for: indexPath) as! HeaderCell
            
            headerCell.profileImage.image = profile.profileImage
            headerCell.petName.text       = profile.petName
            headerCell.petBreed.text      = profile.petBreed
            headerCell.petDOB.text        = profile.petDOB
            
            headerCell.contentView.layer.cornerRadius = 10
            
            return headerCell
            
        } else if indexPath.section == 1 {
            
            let needsCell = tableView.dequeueReusableCell(withIdentifier: K.needsListNib, for: indexPath) as! NeedsListCell
            
            if indexPath.row < profile.needs.count {
                let profileNeeds = profile.needs[indexPath.row]
                
                needsCell.typeLabel.text      = "\(profileNeeds.type)  "
                needsCell.titleDetails.text   = profileNeeds.title
                needsCell.detailsDetails.text = profileNeeds.details
                
                needsCell.contentView.layer.cornerRadius = 10
            }
            
            return needsCell
        } else {
            
            return ProfileCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if profile.needs.isEmpty {
            return 244
            
        } else {
            return 260
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // note that indexPath.section is used rather than indexPath.row
            print("You tapped cell number \(indexPath.section).")
        }
    
  
}
