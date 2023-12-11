//
//  AboutVC.swift
//  Brian
//
//  Created by James Attersley on 30/10/2023.
//

import UIKit
import StoreKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutImage: UIImageView!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutView.layer.cornerRadius  = 8
        buttonView.layer.cornerRadius = 8
        aboutImage.image = UIImage(named: "AboutImage")
        aboutLabel.text  = "Meet Brian, an app born out of the daily struggle to keep up with all the needs of our beloved dogs, Brian and Maeve.\n\nDeveloped with love and a passion for enhancing the pet ownership experience. Brian app is a continually evolving solution and we welcome your feedback and suggestions."
    }
    
    @IBAction func contactPressed(_ sender: UIButton) {
        
        let email = "contactappja@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    @IBAction func tsAndCsPressed(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://www.google.com")!)
    }
    
    @IBAction func privacyPressed(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://www.google.com")!)
    }
    
    @IBAction func ratePressed(_ sender: UIButton) {
        if #available(iOS 14.0, *) {
          if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
             SKStoreReviewController.requestReview(in: scene)
           }
              } else {
                 SKStoreReviewController.requestReview()
        }
    }
}
