//
//  NeedsCollectionViewCell.swift
//  Brian
//
//  Created by James Attersley on 29/08/2023.
//

import UIKit

protocol NeedsCellDelegate: AnyObject {
    
    func passNeedsAdded(need: String?)
    func deselectButtons(sender: UIButton)
}

class NeedsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var needsButton: UIButton!
    
    weak var delegate : NeedsCellDelegate?
    var needSelected  : String?
    var buttonSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        needsButton.sizeToFit()
    }

    func didSelectButton(withText text: String) {
           needSelected = text
       }
    
//    func updateUI(sender: UIButton) {
//        
//        if isSelected {
//            buttonSelected = true
////            sender.isSelected = true
//            needSelected = sender.currentTitle
//            sender.configuration?.baseForegroundColor = UIColor(named: "Background")
//            sender.configuration?.baseBackgroundColor = UIColor(named: "Button")
//            
//        } else {
//            
//            buttonSelected = false
//          
//            needSelected = nil
//            sender.configuration?.baseForegroundColor = UIColor(named: "Button")
//            sender.configuration?.baseBackgroundColor = UIColor(named: "TileBackground")
//            
//        }
//    }
    
    @IBAction func needsButtonPressed(_ sender: UIButton) {
        
        delegate?.deselectButtons(sender: sender)
        
        needsButton.isSelected.toggle()
        
        if needsButton.isSelected {
            buttonSelected = true
            sender.isSelected = true
            needSelected = sender.currentTitle
            sender.configuration?.baseForegroundColor = UIColor(named: "Background")
            sender.configuration?.baseBackgroundColor = UIColor(named: "Button")
        } else {
            buttonSelected = false
            sender.isSelected = false
            needSelected = nil
            sender.configuration?.baseForegroundColor = UIColor(named: "Button")
            sender.configuration?.baseBackgroundColor = UIColor(named: "TileBackground")
        }
            
            if let text = needsButton.titleLabel?.text {
                if needsButton.isSelected {
                    delegate?.passNeedsAdded(need: text)
                } else {
                    needsButton.isSelected = false
                    delegate?.passNeedsAdded(need: nil)
                }
        }
    }
}
