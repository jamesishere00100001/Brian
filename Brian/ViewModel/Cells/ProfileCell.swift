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

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var petImage     : UIImageView!
    @IBOutlet weak var petNameLabel : UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petDOBLabel  : UILabel!
    
    weak var delegate: NeedsSegueDelegate?
    var indexPath    : IndexPath?
    var styling      = Styling()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        petImage = styling.avatarSetup(avatarImage: petImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func cellAddNeedsPressed(_ sender: UIButton) {
        
        if let indexPath = indexPath {
            self.delegate?.addNeedsPressed(indexPath: indexPath)
        }
    }
}
