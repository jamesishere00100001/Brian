//
//  NeedsCollectionViewCell.swift
//  Brian
//
//  Created by James Attersley on 29/08/2023.
//

import UIKit

protocol NeedsCellDelegate: AnyObject {
    
    func passNeedsAdded(need: String)
}

class NeedsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var needsButton: UIButton!
    
    weak var delegate: NeedsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func needsButtonPressed(_ sender: UIButton) {
        
        if needsButton.isSelected        == false {
            needsButton.isSelected       = true
            
//        } else if needsButton.isSelected == true {
//            needsButton.isSelected       = false
        }
        
        if let need = needsButton.titleLabel?.text {
                
            self.delegate?.passNeedsAdded(need: need)
        }
    }
}
