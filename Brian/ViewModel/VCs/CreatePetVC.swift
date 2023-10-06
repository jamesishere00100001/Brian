//
//  ViewController.swift
//  Brian
//
//  Created by James Attersley on 09/06/2023.
//

import UIKit
import Photos
import PhotosUI
import FirebaseCore
import FirebaseFirestore
import RealmSwift

class CreatePetVC: UIViewController, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var breedTextBox: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        avatarImage = styling.avatarSetup(avatarImage: avatarImage)
        avatarImage.image = userPickedImage
        
        nameTextBox = styling.underlinedTF(textfield: nameTextBox)
        breedTextBox = styling.underlinedTF(textfield: breedTextBox)
        
//        saveButton.frame = CGRect(x: 0, y: 0, width: 251, height: 51)
//        saveButton.backgroundColor = .white
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        scrollView.isScrollEnabled = true
    }
    
    let realm = try! Realm()
    
    private var textFieldsFilled: Bool = false
    private var dobDateEntered  : Bool = false
    
    let styling = Styling()
    
    var newProfile = Profile()
    
    var petName : String = ""
    var petBreed: String = ""
    var petDOB  : String = ""
    
    var userPickedImage = UIImage(named: "Profile")
    var userPickedImageURL: String = ""
    
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
    
    //MARK: - DOB text box date entry and manipulation
    
    @IBAction func dobDatePicker(_ sender: UIDatePicker) {
        
        petDOB = UKDate().ukDate(dob: sender.date)
        dobDateEntered = true
        dismiss(animated: true)
    }
    
    //MARK: - Change photo button functionality
    
    @IBAction func changePhotoButton(_ sender: UIButton) {
        
        openPhPicker()
    }
    
    //MARK: - Save button functionality
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        allTextEntered()
        
        if textFieldsFilled == true {
            
            userPickedImage = loadImage(fileName: userPickedImageURL)
//            userPickedImage = styling.resizeImage(image: userPickedImage!, newSize: 200)
            avatarImage.image = userPickedImage
            
            newProfile.petName         = petName
            newProfile.petBreed        = petBreed
            newProfile.petDOB          = petDOB
            newProfile.profilePhotoURL = userPickedImageURL
            
            
            try! realm.write {
                realm.add(newProfile)
            }
//            Database().fireStoreSave(profile: profile)
            
            dismiss(animated: true)
            
        } else {
            print("Error, user input not meeting 'textFieldsFilled' criteria")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.needs {
            let destinationVC = segue.destination as! AddNeedsVC
            
            destinationVC.profile = self.newProfile
        }
    }
    
    
    //MARK: - Image picker VC and VC launcher
        
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                
                if let error = error {
                    print("Error loading image from picker: \(error)")
                }
                
                else if let image = selectedImage as? UIImage {
                    self.userPickedImage = image
                    DispatchQueue.main.async {
                        self.avatarImage.image = image
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
        
        //MARK: - Load image from URL
    
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    
        private func loadImage(fileName: String) -> UIImage? {
            let fileURL = documentsUrl.appendingPathComponent(fileName)
            do {
                let imageData = try Data(contentsOf: fileURL)
                userPickedImageURL = fileURL.absoluteString
                return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
            return nil
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

