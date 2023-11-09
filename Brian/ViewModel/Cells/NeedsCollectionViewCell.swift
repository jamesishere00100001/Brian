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

    func didSelectButton(withText text: String) {
           needsSelected.append(text)
       }
    
    @IBAction func needsButtonPressed(_ sender: UIButton) {
        
        needsButton.isSelected.toggle()
        
        if sender.isSelected {
            sender.configuration?.baseForegroundColor = UIColor(named: "Background")
            sender.configuration?.baseBackgroundColor = UIColor(named: "Button")
            
        } else {
              sender.configuration?.baseForegroundColor = UIColor(named: "Button")
              sender.configuration?.baseBackgroundColor = UIColor(named: "NeedsCellSelected")
              }
        
        if let text = needsButton.titleLabel?.text {
                if needsButton.isSelected {
                    delegate?.passNeedsAdded(need: text)
                }
            }
        }
}
