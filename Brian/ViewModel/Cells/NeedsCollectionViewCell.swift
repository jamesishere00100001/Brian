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
        
        needsButton.isSelected = false
        needsButton.sizeToFit()
    }
    
//    func buttonSelected(button: UIButton) {
//        if button.isSelected {
//            button.tintColor = UIColor(named: "NeedsButtonSelected")
//            button.titleLabel?.textColor = UIColor(named: "Text")
//        } else {
//            button.tintColor = UIColor(named: "Text")
//            button.titleLabel?.textColor = UIColor(named: "Background")
//        }
//        
//    }
    
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
        
        if sender.isSelected {
            sender.configuration?.baseForegroundColor = UIColor(named: "Background")
            sender.configuration?.baseBackgroundColor = UIColor(named: "Button")
//            sender.titleLabel?.textColor = UIColor(named: "Button")
              } else {
                  
                  sender.configuration?.baseForegroundColor = UIColor(named: "Button")
                  sender.configuration?.baseBackgroundColor = UIColor(named: "NeedsCellSelected")
              }
//        buttonSelected(button: sender)
        
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
