//
//  ProfileCell.swift
//  Brian
//
//  Created by James Attersley on 25/07/2023.
//

import UIKit

protocol NeedsSegueDelegate: AnyObject {

    func addNeedsPressed(indexPath: IndexPath)
}

protocol MenuButtonDelegate: AnyObject {
    
    func profileMenuPressed(menuRequest: String)
    func passIndex(index: IndexPath)
}

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var petImage         : UIImageView!
    @IBOutlet weak var petNameLabel     : UILabel!
    @IBOutlet weak var petBreedLabel    : UILabel!
    @IBOutlet weak var petDOBLabel      : UILabel!
    @IBOutlet weak var needsLabel       : UILabel!
        
    weak var delegate     : NeedsSegueDelegate?
    weak var menuDelegate : MenuButtonDelegate?
    var indexPath         : IndexPath?
    var styling           = Styling()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        petImage = styling.avatarSetup(avatarImage: petImage)
        
//        menuButton.showsMenuAsPrimaryAction = true
//        
//        let menuHandler: UIActionHandler = { (action) in
//            if action.title == NSLocalizedString("View needs", comment: "") {
////                performSegue(withIdentifier: K.Segue.needsList, sender: self)
//                
//                
//                if let indexPath = self.indexPath {
//                    print("Menu button pressed inside ProfileCell")
//                    print(indexPath)
//                    self.menuDelegate?.profileMenuPressed(menuRequest: K.Segue.needsList)
//                    self.menuDelegate?.passIndex(index: indexPath)
//                }
//                //need to add delegate to pass UIMenu segue request to HomeVC
//            } else if action.title == NSLocalizedString("Add need", comment: "") {
//                self.menuDelegate?.profileMenuPressed(menuRequest: K.Segue.needs)
//            
//            } else if action.title == NSLocalizedString("Edit", comment: "") {
//                
//            } else if action.title == NSLocalizedString("Share", comment: "") {
//                
//            } else if action.title == NSLocalizedString("Delete", comment: "") {
//                // Delete action
//            }
//        }
//        
//        let menu = UIMenu(title: "", children: [
//            UIAction(title: NSLocalizedString("View needs", comment: ""), image: UIImage(systemName: "arrow.right"), handler: menuHandler),
//            UIAction(title: NSLocalizedString("Add need", comment: ""), image: UIImage(systemName: "plus"), handler: menuHandler),
//            UIAction(title: NSLocalizedString("Edit", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
//            UIAction(title: NSLocalizedString("Share", comment: ""), image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler),
//            UIAction(title: NSLocalizedString("Delete", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)
//        ])
//        
//        menuButton.menu = menu
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func menuButtonPressed(_ sender: UIButton) {
//        guard let cell = sender.superview?.superview as? ProfileCell else {
//            
//            print("Error getting indexpath from cell button - ProfileCellVC")
//            return
//        }
//        self.indexPath = cell.indexPath
//        print("indexPath generated in Profile Cell")
//
//    }
    
    @IBAction func cellAddNeedsPressed(_ sender: UIButton) {
        
        if let indexPath = indexPath {
            print("indexPath passed via delgate to HomeVC")
            self.delegate?.addNeedsPressed(indexPath: indexPath)
        }
    }
}
