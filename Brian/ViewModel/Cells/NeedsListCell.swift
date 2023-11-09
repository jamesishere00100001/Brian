//
//  NeedsListCell.swift
//  Brian
//
//  Created by James Attersley on 16/10/2023.
//

import UIKit

protocol MenuDelegate: AnyObject {
    func menuPressed(button: String, index: IndexPath)
}

class NeedsListCell: UITableViewCell {
    
    @IBOutlet weak var menuButton       : UIButton!
    @IBOutlet weak var typeLabel        : UILabel!
    @IBOutlet weak var titleDetails     : UILabel!
    @IBOutlet weak var detailsDetails   : UILabel!
    
    weak var menuDelegate : MenuDelegate?
    var indexPath         : IndexPath?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        typeLabel.layer.cornerRadius  = 5
        typeLabel.layer.masksToBounds = true
        
        menuButton.showsMenuAsPrimaryAction = true
        
        //MARK: - UIMenu in cell functionality
        
        let menuHandler: UIActionHandler = { (action) in
             if action.title == NSLocalizedString("Edit need", comment: "") {
                if let indexPath = self.indexPath {
                    print("Menu edit button pressed inside ProfileCell")
                    self.menuActionRequest(button: "edit", index: indexPath)
                }
            } else if action.title == NSLocalizedString("Share this need", comment: "") {
                if let indexPath = self.indexPath {
                    print("Menu shareThisNeed button pressed inside ProfileCell")
                    let cell = self
                    let listVC = NeedsListVC()
                    listVC.cell = cell
                    self.menuActionRequest(button: "shareThisNeed", index: indexPath)
                }
                
            } else if action.title == NSLocalizedString("Delete need", comment: "") {
                if let indexPath = self.indexPath {
                    print("Menu delete button pressed inside ProfileCell")
                    self.menuActionRequest(button: "delete", index: indexPath)
                }
            }
        }
        
        let menu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Edit need", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Share this need", comment: ""), image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Delete need", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)])
        
        menuButton.menu = menu
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func menuActionRequest(button: String, index: IndexPath) {
        self.menuDelegate?.menuPressed(button: button, index: index)
    }
}
