//
//  ViewController.swift
//  Brian
//
//  Created by James Attersley on 09/06/2023.
//

import UIKit

import PhotosUI
import RealmSwift

class CreatePetVC: UIViewController, PHPickerViewControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var avatarImage  : UIImageView!
    @IBOutlet weak var nameTextBox  : UITextField!
    @IBOutlet weak var breedTextBox : UITextField!
    @IBOutlet weak var dobTextBox   : UITextField!
    @IBOutlet weak var datePicker   : UIDatePicker!
    
    private var textFieldsFilled: Bool = false
    private var dobDateEntered  : Bool = false
    
    var profile           = Profile()
    let styling           = Styling()
    var userPickedImage   : UIImage?
    var petName           : String = ""
    var petBreed          : String = ""
    var petDOB            : String = ""
    var userPickedImageURL: String = ""
    var editingPet        : Bool   = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        avatarImage       = styling.avatarSetup(avatarImage: avatarImage)
        avatarImage.image = UIImage(named: "profile")
        
        nameTextBox  = styling.underlinedTF(textfield: nameTextBox)
        breedTextBox = styling.underlinedTF(textfield: breedTextBox)
        dobTextBox   = styling.underlinedTF(textfield: dobTextBox)
        
        nameTextBox.delegate  = self
        breedTextBox.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag = textField.tag + 1
        let nextTF  = textField.superview?.viewWithTag(nextTag) as UIResponder?
        if nextTF  != nil {
           nextTF?.becomeFirstResponder()
        } else {
           textField.resignFirstResponder()
        }
        return false
    }
    
    //MARK: - DOB text box date entry and manipulation
    
    @IBAction func dobDatePicker(_ sender: UIDatePicker) {
        
        petDOB = UKDate().ukDate(dob: sender.date)
        dobDateEntered = true
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Change photo button functionality
    
    @IBAction func changePhotoButton(_ sender: UIButton) {
        
        openPhPicker()
    }

    //MARK: - Save button functionality
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        allTextEntered()
        
        if let image = userPickedImage {
            if let imageURL = saveImageToDocumentDirectory(image, withFileName: "\(petName)profile.jpg") {
                userPickedImageURL = imageURL.absoluteString
            }
        }
        
        if textFieldsFilled == true {
            
            let realm = try! Realm()
            
            if editingPet == false {
                
                try! realm.write {
                    
                    let newProfile             = Profile()
                    newProfile.petName         = petName
                    newProfile.petBreed        = petBreed
                    newProfile.petDOB          = petDOB
                    newProfile.profilePhotoURL = userPickedImageURL
                    
                    realm.add(newProfile)
                }

                performSegue(withIdentifier: K.Segue.backHome, sender: self)
                
            } else if editingPet == true {
                
                 try! realm.write {
                    
                     let pet = Profile(value: ["id"             : profile.id,
                                               "petName"        : petName,
                                               "petBreed"       : petBreed,
                                               "petDOB"         : petDOB,
                                               "profilePhotoURL": userPickedImageURL,
                                               "needs"          : profile.needs])
                     
                     realm.add(pet, update: .modified)
                }
                
              performSegue(withIdentifier: K.Segue.backHome, sender: self)
                
            } else {
                print("Error, user input not meeting 'textFieldsFilled' criteria")
            }
        }
    }
    
    //MARK: - Image picker VC and VC launcher
    
    func checkPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.openPhPicker()
                }
            case .denied, .restricted:
                let alert = UIAlertController(title: "No photo access", message: "Without access to your photo library, you will not be able to add an image of your pet. To amend this, check 'privacy' permissions within settings.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okButton)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            case .notDetermined:
                let alert = UIAlertController(title: "No photo access possible", message: "Without access to your photo library, you will not be able to add an image of your pet. Please check 'privacy' permissions within settings.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okButton)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            default:
                fatalError("Unhandled case")
            }
        }
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)

        let imageViewSize = avatarImage.bounds.size

        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "An error has occurred when trying to access your photos. Please check your 'privacy' setting and try again.", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .cancel)
                        alert.addAction(ok)
                        self.present(alert, animated: true)
                    }
                    print("Error loading image from picker: \(error)")
                    print(selectedImage.debugDescription)
                } else if let image = selectedImage as? UIImage {
                    self.userPickedImage = self.styling.resizeAndRoundImage(image: image, imageViewSize: imageViewSize)
                    DispatchQueue.main.async {
                        self.avatarImage.image = self.userPickedImage
                    }
                } else {
                    print("Unable to load image to 'avatar' UIImageView")
                }
            }
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

        
        //MARK: - Save image to Document Directory
    
    func saveImageToDocumentDirectory(_ image: UIImage, withFileName fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return nil
        }

        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image to file: \(error)")
            return nil
        }
    }
    
        //MARK: - Check all user details have been entered to progress to next screen
        
        private func allTextEntered() {
            if nameTextBox.hasText == true {
                petName  = nameTextBox.text!
                petBreed = breedTextBox.text!
                textFieldsFilled = true
                
            } else {
                let alert = UIAlertController(title: "Pet name", message: "Please enter your pet's name", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "Ok", style: .cancel)
                
                alert.addAction(cancelButton)
                
                present(alert, animated: true)
            }
        }
}

