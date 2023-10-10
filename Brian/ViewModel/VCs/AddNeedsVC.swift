//
//  AddNeedsVC.swift
//  Brian
//
//  Created by James Attersley on 01/08/2023.
//

import UIKit

class AddNeedsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var needs                   = Needs()
    var profile                 = Profile()
    var needsSelected: [String] = []
    var nextButtonIsActive      = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        collectionView.autoresizesSubviews = true
        
        self.collectionView.register(UINib(nibName: K.needsCollectionVC, bundle: nil), forCellWithReuseIdentifier: K.needsCollectionVCNib)
    }
    
    //MARK: - Next button action and segue prep
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if needsSelected.isEmpty == false {
            
            performSegue(withIdentifier: K.Segue.addNeedsTwo, sender: sender)
        }
    }
    
    func activateNextButton() {
        
        if nextButtonIsActive == true {
            nextButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.addNeedsTwo {
            let destinationVC = segue.destination as! AddNeedsTwoVC
            
            destinationVC.needsSelected = self.needsSelected
            destinationVC.profile       = self.profile
        }
    }
    
    //MARK: - CollectionView datasouce and delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return needs.needsLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.needsCollectionVCNib, for: indexPath) as! NeedsCollectionViewCell
        cell.needsButton.setTitle(needs.needsLabels[indexPath.row], for: .normal)
        
        cell.delegate = self
        
        collectionView.invalidateIntrinsicContentSize()
        
        return cell
    }
}

//MARK: - Need data delegate from CollectionVC

extension AddNeedsVC: NeedsCellDelegate {
    
    func passNeedsAdded(need: String) {
        if !needsSelected.contains(need) {
            
            self.needsSelected.append(need)
            
            nextButtonIsActive = true
            activateNextButton()
                   
            print("AddNeedsVC needsSelected array = \(needsSelected)")
        }
    }
}


