//
//  HomeVC.swift
//  Brian
//
//  Created by James Attersley on 25/07/2023.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NibSegueDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let blankCell: [Profile] = []
    
    override func viewDidLoad() {
        
        let label = UILabel()
        label.text = "Brian"
        label.font = UIFont(name: "Caprasimo-Regular", size: 28)
        label.textColor = UIColor(named: "Text")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.profileCell, bundle: nil), forCellReuseIdentifier: K.profileCellNib)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let nav = segue.destination as? UINavigationController, let nibClass = nav.topViewController as? ProfileCell { nibClass.delegate = self }
//    }
    
    func cellAddButtonPressed() {
        
        performSegue(withIdentifier: K.Segue.addPet, sender: self)
    }
}
    
extension HomeVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.profileCellNib, for: indexPath) as! ProfileCell
        cell.contentView.layer.cornerRadius = 10
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222
    }
}
   
