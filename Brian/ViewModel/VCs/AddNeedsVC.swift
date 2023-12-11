//
//  AddNeedsVC.swift
//  Brian
//
//  Created by James Attersley on 01/08/2023.
//

import UIKit

class AddNeedsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton    : UIButton!
    
    var needs                   = Needs()
    var profile                 = Profile()
    var needSelected            : String?
    var need                    : String = ""
    var nextButtonIsActive      = false
    var editDetails             : String?
    var editingNeed             : Bool   = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        for cell in collectionView.visibleCells {
            if let customCell = cell as? NeedsCollectionViewCell {
                customCell.needsButton.isSelected = false
                customCell.needsButton.configuration?.baseForegroundColor = UIColor(named: "Button")
                customCell.needsButton.configuration?.baseBackgroundColor = UIColor(named: "TileBackground")
                needSelected = nil
            }
        }
        
//        if editingNeed == true {
//        for cell in collectionView.visibleCells {
//            if let customCell = cell as? NeedsCollectionViewCell {
//                
//                    if let label = customCell.needsButton.titleLabel?.text {
//                        if label == needSelected  {
//                            customCell.needsButton.configuration?.baseForegroundColor = UIColor(named: "Background")
//                            customCell.needsButton.configuration?.baseBackgroundColor = UIColor(named: "Button")
//                        }
//                    }
//                }
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource          = self
        collectionView.delegate            = self
        collectionView.autoresizesSubviews = true
        
        for cell in collectionView.visibleCells {
            if let customCell = cell as? NeedsCollectionViewCell {
                if editingNeed {
                    
                    if let label = customCell.needsButton.titleLabel?.text {
                        if label == need  {
                            customCell.needsButton.configuration?.baseForegroundColor = UIColor(named: "Background")
                            customCell.needsButton.configuration?.baseBackgroundColor = UIColor(named: "Button")
                        }
                    }
                }
            }
        }
        
        nextButton.isHidden = true
        
        self.collectionView.register(UINib(nibName: K.needsCollectionVC, bundle: nil), forCellWithReuseIdentifier: K.needsCollectionVCNib)
    }
    
    //MARK: - Next button action and segue prep
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if needSelected != nil {
            performSegue(withIdentifier: K.Segue.addNeedsTwo, sender: sender)
        }
    }
    
    @IBAction func nextButtonEnable(_ sender: UIButton) {
        if sender.isEnabled {
            nextButton.configuration?.baseBackgroundColor = UIColor(named: "Button")
            nextButton.configuration?.baseForegroundColor = UIColor(named: "Background")
        }
    }
    
    func activateNextButton() {
        
        if nextButtonIsActive   == true {
            nextButton.isEnabled = true
            
        } else {
            nextButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.addNeedsTwo {
            let destinationVC = segue.destination as! AddNeedsTwoVC
            
            if let need = needSelected {
                destinationVC.needSelected = need
                destinationVC.need         = need
            }
                destinationVC.profile      = self.profile
                destinationVC.editingNeed  = self.editingNeed
            
            if editDetails != nil {
                destinationVC.needLabel.text = self.editDetails
            }
        }
    }
    
    //MARK: - CollectionView datasouce and delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return needs.needsLabels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.needsCollectionVCNib, for: indexPath) as! NeedsCollectionViewCell
        cell.needsButton.setTitle(needs.needsLabels[indexPath.row], for: .normal)
        cell.needsButton.isSelected = false
        cell.delegate = self
    
        collectionView.invalidateIntrinsicContentSize()
        
        return cell
    }
}

//MARK: - Need data delegate from CollectionVC

extension AddNeedsVC: NeedsCellDelegate {
 
    func passNeedsAdded(need: String?) {
            
        self.needSelected = need
        
        if needSelected != nil {
        
            performSegue(withIdentifier: K.Segue.addNeedsTwo, sender: self)
            
            nextButtonIsActive = true
            activateNextButton()
        } else {
            
            nextButtonIsActive = false
            activateNextButton()
        }
    }
    
    func deselectButtons(sender: UIButton) {
        
        sender.configuration?.baseForegroundColor = UIColor(named: "Background")
        sender.configuration?.baseBackgroundColor = UIColor(named: "Button")
    }
}


