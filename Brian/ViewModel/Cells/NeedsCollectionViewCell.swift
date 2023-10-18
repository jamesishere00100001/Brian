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
    var needsSelected: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        needsButton.sizeToFit()
    }
    
    func didSelectButton(withText text: String) {
           needsSelected.append(text)
       }

//    func didDeselectButton(withText text: String) {
//        if let indexToRemove = needsSelected.firstIndex(of: text) {
//            needsSelected.remove(at: indexToRemove)
//        }
//    }
    
    @IBAction func needsButtonPressed(_ sender: UIButton) {
        
        needsButton.isSelected.toggle()
        
        if let text = needsButton.titleLabel?.text {
                if needsButton.isSelected {
//                    didSelectButton(withText: text)
                    delegate?.passNeedsAdded(need: text)
//                } else {
//                    didDeselectButton(withText: text)
//                    delegate?.passNeedsAdded(need: needsSelected)
                }
            }
        }
}
