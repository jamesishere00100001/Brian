//
//  ProfileVC.swift
//  Brian
//
//  Created by James Attersley on 12/06/2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var dropShadowImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropShadowImage.layer.masksToBounds = false
        dropShadowImage.layer.cornerRadius = dropShadowImage.frame.height/2
        dropShadowImage.clipsToBounds = true
        
        dropShadowImage.bringSubviewToFront(avatarImage)
        avatarImage.image = userData.userPickedImage
    
    }
    
    var userData = CreatePetVC()
    
    
    
    
    
}


