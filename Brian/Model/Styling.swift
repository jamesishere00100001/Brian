//
//  Styling.swift
//  Brian
//
//  Created by James Attersley on 26/07/2023.
//

import UIKit

class Styling: UITextField {
    
    //MARK: - Provide underline/bottom border only to textfield
    
    func underlinedTF(textfield: UITextField) -> UITextField {
        
        let underLine = CALayer()
        underLine.frame = CGRect(x: 0.0, y: textfield.frame.height - 1, width: textfield.frame.width, height: 1.0)
        underLine.backgroundColor = UIColor.black.cgColor
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(underLine)
        
        return textfield
    }
    
    //MARK: - Set avatar image to circle
    
    func avatarSetup(avatarImage: UIImageView) -> UIImageView {
        
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.clipsToBounds = true
        
        return avatarImage
    }
    
    //MARK: - User image resizing to fit avatar imageview
    
    func resizeImage(image: UIImage, newSize: CGFloat) -> UIImage {
        
        let resizeW = newSize / image.size.width
        let resizeH = newSize / image.size.height
        let scaleFactor = min(resizeW, resizeH)

        let scaledImageSize = CGSize(
            width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)

        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let newImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        
        return newImage
    }
}
