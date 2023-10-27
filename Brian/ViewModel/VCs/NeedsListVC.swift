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
    
    var profile      = Profile()
    let realm        = try! Realm()
    let cellVC       = NeedsListCell()
    let menuAction   = Menu()
    var cell         = NeedsListCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.headerCell, bundle: nil), forCellReuseIdentifier: K.headerCellNib)
        tableView.register(UINib(nibName: K.needsListCell, bundle: nil), forCellReuseIdentifier: K.needsListNib)
        
        let menuHandler: UIActionHandler = { (action) in
            if action.title == NSLocalizedString("Add need", comment: "") {
                self.performSegue(withIdentifier: K.Segue.newNeeds, sender: self)
                
            } else if action.title == NSLocalizedString("Share all needs", comment: "") {
                self.shareTVPDF(petName: self.profile.petName)
                
            } else if action.title == NSLocalizedString("Edit", comment: "") {
                
            } else if action.title == NSLocalizedString("Delete pet", comment: "") {
                self.deleteProfile(petName: self.profile)
            }
        }
        
        let menu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Add need", comment: ""), image: UIImage(systemName: "plus"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Share all needs", comment: ""), image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Edit", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Delete pet", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)
        ])
        
        menuButton.menu = menu
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.newNeeds {
            let destinationVC = segue.destination as! AddNeedsVC
            
            destinationVC.profile = self.profile
        }
    }
    
    // MARK: - Tableview methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
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
                needsCell.indexPath           = indexPath
                needsCell.menuDelegate        = self
                
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
        print("You tapped cell number \(indexPath.section)\(indexPath.row).")
    }
    
    
    //MARK: - Share and delete methods
  
    func shareTVPDF(petName: String) {
        
        let priorBounds: CGRect     = self.tableView!.bounds
        let fittedSize: CGSize      = self.tableView!.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.tableView!.contentSize.height))
        let pdfPageBounds: CGRect   = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
        let pdfData: NSMutableData  = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        self.tableView!.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let date = Date().formatted(date: .abbreviated, time: .omitted)
        let documentsFileName = documentDirectories! + "/" + "\(petName)_" + "\(date)" + ".pdf"
        pdfData.write(toFile: documentsFileName, atomically: true)
        
        let fileURL = URL(fileURLWithPath: documentsFileName)
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func shareTVCPDF(petName: String, need: String, cell: NeedsListCell) {
       
        let pdfPageBounds = cell.bounds
        let pdfData       = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        UIGraphicsGetCurrentContext()?.translateBy(x: -cell.frame.origin.x, y: -cell.frame.origin.y)
        cell.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let date = Date().formatted(date: .abbreviated, time: .omitted)
        let pdfFileName = documentDirectories! + "/" + "\(petName)/\(need)_" + "\(date)" + ".pdf"
        pdfData.write(toFile: pdfFileName, atomically: true)
        
        let fileURL = URL(fileURLWithPath: pdfFileName)
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //    Delete pet profile
    
    func deleteProfile(petName: Profile) {
       
        let alert  = UIAlertController(title: "Delete \(petName.petName)", message: "Are you sure?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteProfileRealm(delete: petName)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        alert.addAction(delete)
        self.present(alert, animated: true)
    }
    
    func deleteProfileRealm(delete item: Profile) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
            self.performSegue(withIdentifier: K.Segue.returnHome, sender: self)
        }
    }
    
    //    Delete pet need from profile
    
    func deleteNeed(need: Needs) {
        
        let alert  = UIAlertController(title: "Delete \(need.title)", message: "Are you sure?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteNeedRealm(delete: need)
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        self.present(alert, animated: true)
    }
    
    func deleteNeedRealm(delete item: Needs) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(item)
            print("Need successfully deleted")
            tableView.reloadData()
        }
    }
}

//MARK: - Delegate methods

    extension NeedsListVC: MenuDelegate {
        
        func menuPressed(button: String, index: IndexPath) {
            
            let need = profile.needs[index.row]
            
            switch button {
            case "edit"         : menuAction.editNeed(need: need)
            case "shareThisNeed": shareTVCPDF(petName: profile.petName, need: need.type, cell: cell)
            case "delete"       : deleteNeed(need: need)
            default             : print("switch statement in NeedsListVC is defaulting")
            }
        }
}
