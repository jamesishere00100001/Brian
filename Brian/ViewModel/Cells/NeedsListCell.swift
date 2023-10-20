//
//  NeedsListCell.swift
//  Brian
//
//  Created by James Attersley on 16/10/2023.
//

import UIKit

class NeedsListCell: UITableViewCell {
    
    @IBOutlet weak var menuButton       : UIButton!
    @IBOutlet weak var typeLabel        : UILabel!
    @IBOutlet weak var titleDetails     : UILabel!
    @IBOutlet weak var detailsDetails   : UILabel!
    
    var menuAction   = Menu()
    var indexPath    : IndexPath?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        typeLabel.layer.cornerRadius  = 5
        typeLabel.layer.masksToBounds = true
        
        menuButton.showsMenuAsPrimaryAction = true
        
        let menuHandler: UIActionHandler = { (action) in
            if action.title == NSLocalizedString("View needs", comment: "") {
//                performSegue(withIdentifier: K.Segue.needsList, sender: self)
                
                
                if let indexPath = self.indexPath {
                    print("Menu button pressed inside ProfileCell")
//                    self.menuDelegate?.profileMenuPressed(menuRequest: K.Segue.needsList)
//                    self.menuDelegate?.passIndex(index: indexPath)
                }
                //need to add delegate to pass UIMenu segue request to HomeVC
            } else if action.title == NSLocalizedString("Edit", comment: "") {
                
            } else if action.title == NSLocalizedString("Share this need", comment: "") {
//                if let cell = sender.superview?.superview as? UITableViewCell {
//                    
//                    menuAction.shareTVCPDF(cell: cell)
//                }
            
                
            } else if action.title == NSLocalizedString("Delete", comment: "") {
                // Delete action
            }
        }
        
        let menu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Edit", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Share this need", comment: ""), image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Delete", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)
        ])
        
        menuButton.menu = menu
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
