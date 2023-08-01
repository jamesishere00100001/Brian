//
//  ProfileCell.swift
//  Brian
//
//  Created by James Attersley on 25/07/2023.
//

import UIKit

protocol NeedsSegueDelegate: AnyObject {

    func addNeedsPressed()
}

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petDOBLabel: UILabel!
    
    weak var delegate: NeedsSegueDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cellAddNeedsPressed(_ sender: UIButton) {
        
        self.delegate?.addNeedsPressed()
    }
    
    
}
