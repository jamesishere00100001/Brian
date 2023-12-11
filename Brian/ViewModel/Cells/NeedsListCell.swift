//
//  NeedsListCell.swift
//  Brian
//
//  Created by James Attersley on 16/10/2023.
//

import UIKit

protocol MenuDelegate: AnyObject {
    func menuPressed(button: String, index: IndexPath)
}

class NeedsListCell: UITableViewCell {
    
    @IBOutlet weak var menuButton       : UIButton!
    @IBOutlet weak var typeLabel        : UILabel!
    @IBOutlet weak var titleDetails     : UILabel!
    @IBOutlet weak var detailsDetails   : UILabel!
    
    weak var menuDelegate : MenuDelegate?
    var indexPath         : IndexPath?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        typeLabel.layer.cornerRadius  = 5
        typeLabel.layer.masksToBounds = true
        
        menuButton.showsMenuAsPrimaryAction = true
        
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(scrollView)
//        scrollView.addSubview(detailsDetails)
//
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
//            detailsDetails.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            detailsDetails.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            detailsDetails.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            detailsDetails.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            detailsDetails.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])
        
        //MARK: - UIMenu in cell functionality
        
        let menuHandler: UIActionHandler = { (action) in
             if action.title == NSLocalizedString("Edit need", comment: "") {
                if let indexPath = self.indexPath {
                    
                    self.menuActionRequest(button: "edit", index: indexPath)
                }
            } else if action.title == NSLocalizedString("Share this need", comment: "") {
                if let indexPath = self.indexPath {
                   
                    let cell = self
                    let listVC = NeedsListVC()
                    listVC.cell = cell
                    self.menuActionRequest(button: "shareThisNeed", index: indexPath)
                }
                
            } else if action.title == NSLocalizedString("Delete need", comment: "") {
                if let indexPath = self.indexPath {
                    
                    self.menuActionRequest(button: "delete", index: indexPath)
                }
            }
        }
        
        let menu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Edit need", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Share this need", comment: ""), image: UIImage(systemName: "square.and.arrow.up"), handler: menuHandler),
            UIAction(title: NSLocalizedString("Delete need", comment: ""), image: UIImage(systemName: "trash"), handler: menuHandler)])
        
        menuButton.menu = menu
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func menuActionRequest(button: String, index: IndexPath) {
        self.menuDelegate?.menuPressed(button: button, index: index)
    }
}
