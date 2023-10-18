//
//  HeaderCell.swift
//  Brian
//
//  Created by James Attersley on 18/10/2023.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var petName      : UILabel!
    @IBOutlet weak var petBreed     : UILabel!
    @IBOutlet weak var petDOB       : UILabel!
    
    let styling = Styling()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        profileImage = styling.avatarSetup(avatarImage: profileImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
