//
//  HomeVC.swift
//  Brian
//
//  Created by James Attersley on 25/07/2023.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var optionBarItem: UIBarButtonItem!
    
    //    let db = Database().db
    // Open the local-only default realm
    let realm = try! Realm()
    
    var profiles: [Profile] = []
    var currentProfile = Profile()
    
    override func viewDidLoad() {
        
        let label  = UILabel()
        label.text = "Brian"
        label.font = UIFont(name: "Caprasimo-Regular", size: 28)
        label.textColor = UIColor(named: "Text")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        let menuHandler: UIActionHandler = { (action) in
            if action.title == NSLocalizedString("Add new", comment: "") {
                self.performSegue(withIdentifier: K.Segue.addPet, sender: self)
                
            } else if action.title == NSLocalizedString("Delete", comment: "") {
                // Delete action
            }
        }

        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Add new", comment: ""), image: UIImage(systemName: "plus"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Delete", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)
        ])
        optionBarItem.menu = barButtonMenu
        
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        loadProfiles()
        
        tableView.register(UINib(nibName: K.blankCell, bundle: nil), forCellReuseIdentifier: K.blankCellNib)
        tableView.register(UINib(nibName: K.profileCell, bundle: nil), forCellReuseIdentifier: K.profileCellNib)
    }
    
    
    
    func loadProfiles() {
        
        let fetchedProfiles = realm.objects(Profile.self)
        
        profiles.append(contentsOf: fetchedProfiles)
    }
    //
    //        db.collection("profiles")
    //            .order(by: K.FStore.dobField)
    //            .addSnapshotListener() { (querySnapshot, error) in
    //                
    //                self.profiles = []
    //                if let e = error {
    //                    print("Error getting documents: \(e)")
    //                    
    //                } else {
    //                    if let snapshotDocuments = querySnapshot?.documents {
    //                        for doc in snapshotDocuments {
    //                            let data = doc.data()
    //                            if let name = data[K.FStore.nameField] as? String, let breed = data[K.FStore.breedField] as? String, let dob = data[K.FStore.dobField] as? String, let image = data[K.FStore.imageField] as? String {
    //                                let newProfile = Profile(petName: name, petBreed: breed, petDOB: dob, profilePhotoURL: image)
    //                                self.profiles.append(newProfile)
    //                                
    //                                DispatchQueue.main.async {
    //                                    self.tableView.reloadData()
    //                                    let indexPath = IndexPath(row: self.profiles.count - 1, section: 0)
    //                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    //                                }
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //    }
    
    
    //MARK: - Load image from URL

    private func loadImage(fileName: String) -> UIImage? {
        
        let stringToUrl = URL(string: fileName)
        
        if let url = stringToUrl {
            do {
                let imageData = try Data(contentsOf: url)
                return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
        }
        return UIImage(named: "profile")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.needs {
            let destinationVC = segue.destination as! AddNeedsVC
            
            destinationVC.profile = self.currentProfile
        }
    }
}
    
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if profiles.isEmpty {
            return 1
            
        } else {
            return profiles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if profiles.isEmpty {
            let blankCell = tableView.dequeueReusableCell(withIdentifier: K.blankCellNib, for: indexPath) as! BlankCell
            blankCell.contentView.layer.cornerRadius = 10
            blankCell.delegate = self
            
            return blankCell
            
        } else {
            let profile = profiles[indexPath.row]
            
            let filledCell                = tableView.dequeueReusableCell(withIdentifier: K.profileCellNib, for: indexPath) as! ProfileCell
            filledCell.petNameLabel.text  = profile.petName
            filledCell.petBreedLabel.text = profile.petBreed
            filledCell.petDOBLabel.text   = profile.petDOB
            filledCell.petImage.image     = loadImage(fileName: profile.profilePhotoURL)
            
            filledCell.delegate = self
            filledCell.indexPath = indexPath
            
            filledCell.contentView.layer.cornerRadius = 10
            filledCell.delegate = self
            
            return filledCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if profiles.isEmpty {
            return 222
            
        } else {
            return 320
        }
    }
}

extension HomeVC: NibSegueDelegate, NeedsSegueDelegate {
    
    //MARK: - Delegate functions
    
    func cellAddButtonPressed() {
        
        performSegue(withIdentifier: K.Segue.addPet, sender: self)
    }
    
    func addNeedsPressed(indexPath: IndexPath) {
        
        currentProfile = profiles[indexPath.row]
        
        performSegue(withIdentifier: K.Segue.needs, sender: self)
    }
}

    

