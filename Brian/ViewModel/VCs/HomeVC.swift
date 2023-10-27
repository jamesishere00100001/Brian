//
//  HomeVC.swift
//  Brian
//
//  Created by James Attersley on 25/07/2023.
//
import UIKit
import RealmSwift

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView    : UITableView!
    @IBOutlet weak var optionBarItem: UIBarButtonItem!
    
    let realm          = try! Realm()
    var profiles       : [Profile] = []
    var currentProfile = Profile()
    var styling        = Styling()
//    var needsExist     = false
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        loadProfiles()
        
        let label       = UILabel()
        label.text      = "Brian"
        label.font      = UIFont(name: "Caprasimo-Regular", size: 28)
        label.textColor = UIColor(named: "Text")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.blankCell, bundle: nil), forCellReuseIdentifier: K.blankCellNib)
        tableView.register(UINib(nibName: K.profileCell, bundle: nil), forCellReuseIdentifier: K.profileCellNib)
        
        //MARK: - Nav bav menu button functionality
        
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
    }
    
    func loadProfiles() {
        
        let fetchedProfiles = realm.objects(Profile.self)
        
        profiles.append(contentsOf: fetchedProfiles)
        
        for profile in profiles {
            profile.profileImage = loadImage(name: profile.petName) ?? UIImage(named: "profile")!
        }
    }
    
    //MARK: - Load image from StringURL
    
    func loadImage(name: String) -> UIImage? {
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let imageURL = documentDirectory.appendingPathComponent("\(name)profile.jpg")
            
            if let image = UIImage(contentsOfFile: imageURL.path) {
                return image
                
            } else {
                print("Failed to create UIImage from the file.")
                return UIImage(named: "profile")
            }
        }
        return UIImage(named: "profile")
    }
}
    
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if profiles.isEmpty {
            return 1
            
        } else {
            return profiles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if profiles.isEmpty {
            let blankCell      = tableView.dequeueReusableCell(withIdentifier: K.blankCellNib, for: indexPath) as! BlankCell
            blankCell.delegate = self
            
            blankCell.contentView.layer.cornerRadius = 10
            
            return blankCell
            
        } else {
            let profile = profiles[indexPath.row]
            
            let filledCell                = tableView.dequeueReusableCell(withIdentifier: K.profileCellNib, for: indexPath) as! ProfileCell
            filledCell.petNameLabel.text  = profile.petName
            filledCell.petBreedLabel.text = profile.petBreed
            filledCell.petDOBLabel.text   = profile.petDOB
            filledCell.petImage.image     = profile.profileImage
            filledCell.needsLabel.text    = "\(profile.needs.count) Needs listed"
            filledCell.indexPath          = indexPath
            filledCell.menuDelegate       = self
            filledCell.delegate           = self
            
            filledCell.contentView.layer.cornerRadius = 10
            
//            doNeedsExist()
//            if !profile.needs.isEmpty {
//                needsExist = true
//            }
            
            return filledCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if profiles.isEmpty {
            return 222
            
        } else {
            return 344
        }
    }
    
//    func doNeedsExist() {
//        if currentProfile.needs.isEmpty {
//            needsExist = false
//        } else {
//            needsExist = true
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentProfile = profiles[indexPath.row]
        performSegue(withIdentifier: K.Segue.needsList, sender: self)
    }
}

extension HomeVC: NibSegueDelegate, NeedsSegueDelegate, MenuButtonDelegate {
   
    //MARK: - Delegate methods
    
    func profileMenuPressed(menuRequest: String) {
        self.performSegue(withIdentifier: menuRequest, sender: self)
    }
    
    func passIndex(index: IndexPath) {
        currentProfile = self.profiles[index.row]
    }
    
    func cellAddButtonPressed() {
        performSegue(withIdentifier: K.Segue.addPet, sender: self)
    }
    
    func addNeedsPressed(indexPath: IndexPath) {
        currentProfile = self.profiles[indexPath.row]
        performSegue(withIdentifier: K.Segue.needs, sender: self)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.needs {
            let destinationVC = segue.destination as! AddNeedsVC
            
            destinationVC.profile = self.currentProfile
            
        } else if segue.identifier == K.Segue.needsList {
            let destinationVC = segue.destination as! NeedsListVC
           
            destinationVC.profile = self.currentProfile
        }
    }
}
    

