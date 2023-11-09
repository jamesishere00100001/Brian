//
//  ShareNeedsCell.swift
//  Brian
//
//  Created by James Attersley on 02/11/2023.
//

import UIKit

class ShareNeedsCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel        : UILabel!
    @IBOutlet weak var titleDetails     : UILabel!
    @IBOutlet weak var detailsDetails   : UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        typeLabel.layer.cornerRadius  = 5
        typeLabel.layer.masksToBounds = true
    }
}
