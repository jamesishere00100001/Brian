//
//  ShareSheetVC.swift
//  Brian
//
//  Created by James Attersley on 02/11/2023.
//

import UIKit

class ShareSheetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var profile       = Profile()
    var cell          = NeedsListCell()
    var shareRequested: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        tableView.delegate   = self
        tableView.dataSource = self
    
        tableView.register(UINib(nibName: K.shareHeaderCell, bundle: nil), forCellReuseIdentifier: K.shareHeaderNib)
        tableView.register(UINib(nibName: K.shareNeedsCell, bundle: nil), forCellReuseIdentifier: K.shareNeedsNib)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shareRequested == "all" {
            shareTVPDF()
        }
        if shareRequested == "cell" {
            shareTVCPDF(cell: cell)
        }
    }
    
    //MARK: - TableView methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
            
            if shareRequested == "all" {
                return profile.needs.count
            }
            if shareRequested == "cell" {
                return 1
            } else {
                return 1
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let shareHeader = tableView.dequeueReusableCell(withIdentifier: K.shareHeaderNib, for: indexPath) as! ShareHeaderCell
            
            shareHeader.profileImage.image = profile.profileImage
            shareHeader.petName.text       = profile.petName
            shareHeader.petBreed.text      = profile.petBreed
            shareHeader.petDOB.text        = profile.petDOB
            
            shareHeader.contentView.layer.cornerRadius = 10
            
            return shareHeader
            
        } else if indexPath.section == 1 {
            
            let shareNeeds = tableView.dequeueReusableCell(withIdentifier: K.shareNeedsNib, for: indexPath) as! ShareNeedsCell
            
            if indexPath.row < profile.needs.count {
                let profileNeeds = profile.needs[indexPath.row]
                
                shareNeeds.typeLabel.text      = "\(profileNeeds.type)  "
                shareNeeds.titleDetails.text   = profileNeeds.title
                shareNeeds.detailsDetails.text = profileNeeds.details
                
                shareNeeds.contentView.layer.cornerRadius = 10
            }
            
            return shareNeeds
        } else {
            
            return ShareNeedsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if profile.needs.isEmpty {
            return 244
            
        } else {
            return 260
        }
    }
    
    func calculateContentSize() -> CGSize {
        let totalHeight = CGFloat(self.tableView.numberOfRows(inSection: 1)) * 260 + 260
        return CGSize(width: self.tableView.bounds.width, height: totalHeight)
    }
    
    func shareTVPDF() {
            
        UIGraphicsBeginImageContextWithOptions(calculateContentSize(), false, 0)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)

        let interationCount: Int = Int(ceil(self.tableView.contentSize.height / self.tableView.bounds.size.height))
            for i in 0..<interationCount {
                self.tableView.setContentOffset(CGPoint(x: 0, y: Int(self.tableView.bounds.size.height) * i), animated: false)
                self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            }

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            activityViewController.dismiss(animated: true) {
                if let navigationController = self.navigationController {
                    navigationController.popViewController(animated: false)
                }
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func calculateCellSize() -> CGSize {
        let totalHeight = CGFloat(520)
        return CGSize(width: self.tableView.bounds.width, height: totalHeight)
    }
    
    func shareTVCPDF(cell: NeedsListCell) {
        
        UIGraphicsBeginImageContextWithOptions(calculateContentSize(), false, 0)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)

        let interationCount: Int = Int(ceil(self.tableView.contentSize.height / self.tableView.bounds.size.height))
            for i in 0..<interationCount {
                self.tableView.setContentOffset(CGPoint(x: 0, y: Int(self.tableView.bounds.size.height) * i), animated: false)
                self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            }

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            activityViewController.dismiss(animated: true) {
                if let navigationController = self.navigationController {
                    navigationController.popViewController(animated: false)
                }
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
}
