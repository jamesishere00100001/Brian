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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func cellAddNeedsPressed(_ sender: UIButton) {
        
        if let indexPath = indexPath {
            print("indexPath passed via delgate to HomeVC")
            self.delegate?.addNeedsPressed(indexPath: indexPath)
        }
    }
}
