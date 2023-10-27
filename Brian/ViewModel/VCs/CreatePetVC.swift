//
//  ViewController.swift
//  Brian
//
//  Created by James Attersley on 09/06/2023.
//

import UIKit
import Photos
import PhotosUI
import RealmSwift

class CreatePetVC: UIViewController, PHPickerViewControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView   : UIScrollView!
    
    @IBOutlet weak var avatarImage  : UIImageView!
    @IBOutlet weak var nameTextBox  : UITextField!
    @IBOutlet weak var breedTextBox : UITextField!
    @IBOutlet weak var dobTextBox   : UITextField!
    
    private var textFieldsFilled: Bool = false
    private var dobDateEntered  : Bool = false
    
    let styling           = Styling()
    var userPickedImage   = UIImage(named: "profile")
    var petName           : String = ""
    var petBreed          : String = ""
    var petDOB            : String = ""
    var userPickedImageURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        avatarImage       = styling.avatarSetup(avatarImage: avatarImage)
        avatarImage.image = userPickedImage
        
        nameTextBox  = styling.underlinedTF(textfield: nameTextBox)
        breedTextBox = styling.underlinedTF(textfield: breedTextBox)
        dobTextBox   = styling.underlinedTF(textfield: dobTextBox)
        
        nameTextBox.delegate  = self
        breedTextBox.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        scrollView.isScrollEnabled = true
    }
    
    //MARK: - Soft keyboard scroll func - Works in conjuction with notificationCentre set up in viewDidLoad
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
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
            
            try! realm.write {
                
                let newProfile             = Profile()
                newProfile.petName         = petName
                newProfile.petBreed        = petBreed
                newProfile.petDOB          = petDOB
                newProfile.profilePhotoURL = userPickedImageURL
                
                realm.add(newProfile)
            }
          
            performSegue(withIdentifier: K.Segue.backHome, sender: self)
        
        } else {
            print("Error, user input not meeting 'textFieldsFilled' criteria")
        }
    }
    
    //MARK: - Image picker VC and VC launcher
        
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let imageViewSize = avatarImage.bounds.size
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                
                if let error = error {
                    print("Error loading image from picker: \(error)")
                }
                
                else if let image = selectedImage as? UIImage {
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
            if nameTextBox.hasText && breedTextBox.hasText && dobDateEntered == true {
                petName  = nameTextBox.text!
                petBreed = breedTextBox.text!
                textFieldsFilled = true
                
            } else {
                let alert = UIAlertController(title: "Uh oh!", message: "You've not finished entering your pet's info", preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "Ok", style: .cancel)
                
                alert.addAction(cancelButton)
                
                present(alert, animated: true)
            }
        }
}

