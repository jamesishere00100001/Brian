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

class CreatePetVC: UIViewController, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var breedTextBox: UITextField!
   
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//
//        scrollView.isScrollEnabled = true
    }
    
    private var textFieldsFilled: Bool = false
    private var dobDateEntered: Bool = false
    
//   var profile = Profile(petName: petName, petBreed: petBreed, petDOB: petDOB, userPickedImage: userPickedImage)
    
    
    
    var petName: String = ""
    var petBreed: String = ""
    var petDOB: String = ""
    
    var saveButton = UIButton()
    
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
        
        petDOB = sender.date.description
        dobDateEntered = true
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
            userPickedImage = resizeImage(image: userPickedImage!, newSize: 200)
            avatarImage.image = userPickedImage
            
            Database().fireStoreSave(petName: petName, petBreed: petBreed, petDOB: petDOB, petImage: userPickedImageURL)
            
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
                     (selectedImage, error) in
                     if let image = selectedImage as? URL {
                         self.userPickedImageURL = image.description
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
        
        //MARK: - Load image from URL
    
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    
        private func loadImage(fileName: String) -> UIImage? {
            let fileURL = documentsUrl.appendingPathComponent(fileName)
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
            return nil
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
        
        //MARK: - Check all user details have been entered to progress to next screen
        
        func allTextEntered() {
            if nameTextBox.hasText && breedTextBox.hasText && dobDateEntered == true {
                petName = nameTextBox.text!
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

