//
//  BlankCell.swift
//  Brian
//
//  Created by James Attersley on 27/07/2023.
//

import UIKit

protocol NibSegueDelegate: AnyObject {

    func cellAddButtonPressed()
}

class BlankCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    weak var delegate: NibSegueDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        avatarImage.image = UIImage(named: "profile")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func addPetButtonPressed(_ sender: UIButton) {
        
        self.delegate?.cellAddButtonPressed()
    }
}
