//
//  ViewController.swift
//  Brian
//
//  Created by James Attersley on 09/06/2023.
//

import UIKit
import Photos
import PhotosUI

class CreatePetVC: UIViewController, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var breedTextBox: UITextField!
    @IBOutlet weak var dobTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        headerImage.layer.masksToBounds = false
//        headerImage.layer.cornerRadius = headerImage.frame.height/2
//        headerImage.clipsToBounds = true
        
        avatarImage.image = userPickedImage
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
    
    var userPickedImage = UIImage(named: "Profile")
    
    //MARK: - Change photo button functionality
    
    @IBAction func changePhotoButton(_ sender: UIButton) {
        
        openPhPicker()
    }
    
    //MARK: - Save button functionality
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        allTextEntered()
        
        if textFieldsFilled == true {
            
            avatarImage.image = resizeImage(image: userPickedImage!, newSize: 200)
            
            performSegue(withIdentifier: "goToProfile", sender: self)
            
        } else {
            print("Error, user input not meeting 'textFieldsFilled' criteria")
        }
    }
    
    //MARK: - Image picker VC and VC launcher
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
             picker.dismiss(animated: true)
             
             for result in results {
                 result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
                     (object, error) in
                     if let image = object as? UIImage {
                         self.userPickedImage = image
                     }
                 })
             }
         }
         
         func openPhPicker() {
             
             var config = PHPickerConfiguration()
             
             config.selectionLimit = 1
             config.filter = PHPickerFilter.images
             
             let phPickerVC = PHPickerViewController(configuration: config)
             
                    phPickerVC.delegate = self
                    present(phPickerVC, animated: true)
         }
        
        //MARK: - User image resizing to fir avatar imageview
        
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
        
        //MARK: - Check all user details have been entered to progress to next screen
        
        func allTextEntered() {
            if nameTextBox.hasText && breedTextBox.hasText && dobTextBox.hasText == true {
                petName = nameTextBox.text!
                petBreed = breedTextBox.text!
                petDOB = dobTextBox.text!
                textFieldsFilled = true
                
            } else {
                let alert = UIAlertController(title: "Uh oh!", message: "You've not finished entering your pet's info", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "Ok", style: .cancel)
                
                alert.addAction(cancelButton)
                
                present(alert, animated: true)
            }
        }

}

