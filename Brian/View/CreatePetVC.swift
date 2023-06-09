//
//  ViewController.swift
//  Brian
//
//  Created by James Attersley on 09/06/2023.
//

import UIKit

class CreatePetVC: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var breedTextBox: UITextField!
    @IBOutlet weak var dobTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImage.layer.masksToBounds = false
        headerImage.layer.cornerRadius = headerImage.frame.height/2
        headerImage.clipsToBounds = true
        
        avatarImage.image = UIImage(named: "Profile")
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.cornerRadius = headerImage.frame.height/2
        avatarImage.clipsToBounds = true
        
        
        saveButton.frame = CGRect(x: 0, y: 0, width: 251, height: 51)
        saveButton.backgroundColor = .white

    }
    
    private var textFieldsFilled: Bool = false
    
    var petName: String = ""
    var petBreed: String = ""
    var petDOB: String = ""
    
    var saveButton = UIButton()
    
    
    @IBAction func changePhotoButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        if textFieldsFilled == true {
            
        }
        
    }
    
    
    // Add your pet
//    var view = UILabel()
//    view.frame = CGRect(x: 0, y: 0, width: 375, height: 50)
//    view.backgroundColor = .white
//
//    view.textColor = UIColor(red: 0.148, green: 0.146, blue: 0.158, alpha: 1)
//    view.font = UIFont(name: "Shrikhand-Regular", size: 32)
//    // Line height: 47 pt
//    view.textAlignment = .center
//    view.text = "Add your pet"
//
//    var parent = self.view!
//    parent.addSubview(view)
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.widthAnchor.constraint(equalToConstant: 375).isActive = true
//    view.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: 0).isActive = true
//    view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 69).isActive = true
    

}

