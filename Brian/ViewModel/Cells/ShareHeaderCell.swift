//
//  ShareHeaderCell.swift
//  Brian
//
//  Created by James Attersley on 02/11/2023.
//

import UIKit

class ShareHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var petName     : UILabel!
    @IBOutlet weak var petBreed    : UILabel!
    @IBOutlet weak var petDOB      : UILabel!
    
    let styling = Styling()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage = styling.avatarSetup(avatarImage: profileImage)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
