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
    
    var profile       = Profile()
    var realm         = try! Realm()
    let cellVC        = NeedsListCell()
    let menuAction    = Menu()
    var cell          = NeedsListCell()
    var editNeed      = Needs()
    var shareRequested: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
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
                self.shareRequested = "all"
                self.performSegue(withIdentifier: K.Segue.shareSheet, sender: self)
                
            } else if action.title == NSLocalizedString("Edit pet", comment: "") {
                self.performSegue(withIdentifier: K.Segue.editPet, sender: self)
                
            } else if action.title == NSLocalizedString("Delete pet", comment: "") {
                self.deleteProfile(petName: self.profile)
            }
        }
        
        let menu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Add need", comment: ""), image: UIImage(systemName: "plus"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Share all needs", comment: ""), image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Edit pet", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Delete pet", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)])
        
        menuButton.menu = menu
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //MARK: - New need segue
        
        if segue.identifier == K.Segue.newNeeds {
            let destinationVC = segue.destination as! AddNeedsVC
            
            destinationVC.profile = self.profile
            
            //MARK: - Edit need segue
            
        } else if segue.identifier == K.Segue.editNeed {
            let destinationVC = segue.destination as! AddNeedsTwoVC
            
            destinationVC.loadViewIfNeeded()
            destinationVC.profile       = profile
            destinationVC.needSelected  = editNeed.type
            destinationVC.needs         = editNeed
            destinationVC.need          = editNeed.type
            destinationVC.editingNeed   = true
//            destinationVC.addNeedTitle(needArray: destinationVC.needsSelected)
            destinationVC.titleTF.text  = editNeed.title
            destinationVC.editDetails   = editNeed.details
            destinationVC.needLabel.text = "Add the \(self.editNeed.type.lowercased()) title"
            
            //MARK: - Edit pet segue
            
        } else if segue.identifier == K.Segue.editPet {
            let destinationVC = segue.destination as! CreatePetVC
            
            destinationVC.loadViewIfNeeded()
            destinationVC.profile            = profile
            destinationVC.avatarImage.image  = profile.profileImage
            destinationVC.userPickedImage    = profile.profileImage
            destinationVC.userPickedImageURL = profile.profilePhotoURL
            destinationVC.nameTextBox.text   = profile.petName
            destinationVC.breedTextBox.text  = profile.petBreed
            destinationVC.petDOB             = profile.petDOB
            destinationVC.editingPet         = true
            
            let dateFormatter                = DateFormatter()
            dateFormatter.dateFormat         = "dd/MM/yyyy"
            if let date = dateFormatter.date(from: profile.petDOB) {
                destinationVC.datePicker.date    = date
            }
        }
        if segue.identifier == K.Segue.shareSheet {
            let destinationVC = segue.destination as! ShareSheetVC
            
            destinationVC.profile = self.profile
            destinationVC.cell    = self.cell
            destinationVC.shareRequested = shareRequested
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
            
            headerCell.contentView.layer.cornerRadius = 8
            
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
                
                needsCell.contentView.layer.cornerRadius = 8
            }
            
            return needsCell
        } else {
            
            return NeedsListCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if profile.needs.isEmpty {
            return 244
            
        } else {
            return 260
        }
    }
    
    
    //MARK: - Share and delete methods
//    func shareTVPDF(petName: String) {
//       
//        let shareSheet   = ShareSheetVC()
//        self.view.addSubview(shareSheet.view)
//        shareSheet.completionHandler = { 
//            
//            let image = shareSheet.shareTVPDF(petName: self.profile.petName)
////            print("NeedsListVC - ShareSheetVC completionHandler triggered")
////            
////            UIGraphicsBeginImageContextWithOptions(shareSheet.tableView.contentSize, false, 0)
////            shareSheet.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
////            shareSheet.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
////            
////            let interationCount: Int = Int(ceil(shareSheet.tableView.contentSize.height / shareSheet.tableView.bounds.size.height))
////            for i in 0..<interationCount {
////                shareSheet.tableView.setContentOffset(CGPoint(x: 0, y: Int(shareSheet.tableView.bounds.size.height) * i), animated: false)
////                shareSheet.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
////            }
////            
////            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
////            UIGraphicsEndImageContext()
////            
//            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//            self.present(activityViewController, animated: true, completion: nil)
//        
//        
//        }
//            shareSheet.view.removeFromSuperview()
//    }
        
//        UIGraphicsBeginImageContextWithOptions(self.tableView.contentSize, false, 0)
//        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//        self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
//
//        let interationCount: Int = Int(ceil(self.tableView.contentSize.height / self.tableView.bounds.size.height))
//            for i in 0..<interationCount {
//                self.tableView.setContentOffset(CGPoint(x: 0, y: Int(self.tableView.bounds.size.height) * i), animated: false)
//                self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
//            }
//
//            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext()
        
//        if let temporaryURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("\(petName)_needList.pdf") {
//            do {
//                try image.pngData()?.write(to: temporaryURL)
//            } catch {
//                print("Error writing png to temporary file: \(error.localizedDescription)")
//            }
//            
//            
//            // Set a completion handler to delete the temporary file after sharing
//            activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
//                do {
//                    // Delete the temporary file
//                    try FileManager.default.removeItem(at: temporaryURL)
//                } catch {
//                    // Handle the error, if any
//                    print("Error deleting temporary file: \(error.localizedDescription)")
//                }
//            }
//        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        self.present(activityViewController, animated: true, completion: nil)
        
//    }
//    func shareTVPDF(petName: String) {
//        // Create a PDF data object in memory
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
//        UIGraphicsBeginPDFPage()
//        guard let context = UIGraphicsGetCurrentContext() else {
//            // Handle the error, if any
//            return
//        }
//        
//        // Ensure the table view is fully rendered
//        if let tableView = self.tableView {
//            tableView.layer.render(in: context)
//        }
//        
//        // Finish creating the PDF
//        UIGraphicsEndPDFContext()
//        
//        // Create a temporary URL for the PDF file (optional)
//        // This step is not needed if you want to avoid saving the PDF to a file
//        // This is just for generating a temporary URL in case you want to save it
//        let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(petName)_\(Date().timeIntervalSince1970).pdf")
//        
//        // Save the PDF data to the temporary URL (optional)
//        do {
//            try pdfData.write(to: temporaryURL, options: .atomic)
//        } catch {
//            // Handle the error, if any
//        }
//        
//        // Share the PDF data using UIActivityViewController
//        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
//        self.present(activityViewController, animated: true, completion: nil)
//    }

    
//    func shareTVPDF(petName: String) {
//        
//        let priorBounds: CGRect     = self.tableView!.bounds
//        let fittedSize: CGSize      = self.tableView!.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.tableView!.contentSize.height))
//        let pdfPageBounds: CGRect   = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
//        let pdfData: NSMutableData  = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
//        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
//        self.tableView!.layer.render(in: UIGraphicsGetCurrentContext()!)
//        UIGraphicsEndPDFContext()
//        
//        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//        let date = Date().formatted(date: .abbreviated, time: .omitted)
//        let documentsFileName = documentDirectories! + "/" + "\(petName)_" + "\(date)" + ".pdf"
//        pdfData.write(toFile: documentsFileName, atomically: true)
//        
//        let fileURL = URL(fileURLWithPath: documentsFileName)
//        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
//        self.present(activityViewController, animated: true, completion: nil)
//    }
    
    func shareTVCPDF(petName: String, need: String, cell: NeedsListCell) {
        
        UIGraphicsBeginImageContextWithOptions(cell.bounds.size, false, 0)
        cell.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let image = image {
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
//    func shareTVCPDF(petName: String, need: String, cell: NeedsListCell) {
//        let pdfPageBounds = cell.bounds
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
//        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
//        UIGraphicsGetCurrentContext()?.translateBy(x: -cell.frame.origin.x, y: -cell.frame.origin.y)
//        cell.layer.render(in: UIGraphicsGetCurrentContext()!)
//        UIGraphicsEndPDFContext()
//
//        // Create a temporary URL for the PDF file
//        if let temporaryURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("\(petName)_\(need).pdf") {
//            pdfData.write(to: temporaryURL, atomically: true)
//
//            let activityViewController = UIActivityViewController(activityItems: [temporaryURL], applicationActivities: nil)
//            // Set a completion handler to delete the temporary file after sharing
//            activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
//                do {
//                    // Delete the temporary file
//                    try FileManager.default.removeItem(at: temporaryURL)
//                } catch {
//                    // Handle the error, if any
//                    print("Error deleting temporary file: \(error.localizedDescription)")
//                }
//            }
//            self.present(activityViewController, animated: true, completion: nil)
//        }
//    }

//    func shareTVCPDF(petName: String, need: String, cell: NeedsListCell) {
//       
//        let pdfPageBounds = cell.bounds
//        let pdfData       = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
//        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
//        UIGraphicsGetCurrentContext()?.translateBy(x: -cell.frame.origin.x, y: -cell.frame.origin.y)
//        cell.layer.render(in: UIGraphicsGetCurrentContext()!)
//        UIGraphicsEndPDFContext()
//        
//        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//        let date = Date().formatted(date: .abbreviated, time: .omitted)
//        let pdfFileName = documentDirectories! + "/" + "\(petName)/\(need)_" + "\(date)" + ".pdf"
//        pdfData.write(toFile: pdfFileName, atomically: true)
//        
//        let fileURL = URL(fileURLWithPath: pdfFileName)
//        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
//        self.present(activityViewController, animated: true, completion: nil)
//    }
    
    //MARK: - Delete pet profile
    
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
    
    //MARK: - Delete pet need from profile
    
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
            tableView.reloadData()
        }
    }
}

//MARK: - Delegate methods

    extension NeedsListVC: MenuDelegate {
        
        func menuPressed(button: String, index: IndexPath) {
            self.tableView.reloadData()
            let need = profile.needs[index.row]
            
            switch button {
            case "edit"         : self.editNeed = need; print(need.title); self.performSegue(withIdentifier: K.Segue.editNeed, sender: self)
            case "shareThisNeed": if let cell = tableView.cellForRow(at: index) as? NeedsListCell { self.cell = cell; self.shareRequested = "cell"; self.performSegue(withIdentifier: K.Segue.shareSheet, sender: self) }
            case "delete"       : deleteNeed(need: need)
            default             : print("switch statement in NeedsListVC is defaulting")
            }
        }
}
