//
//  Menu.swift
//  Brian
//
//  Created by James Attersley on 20/10/2023.
//

import UIKit

class Menu: UITableViewController {
    
    //    TableView to PDF and present sharesheet
    
    func shareTVPDF(petName: String) {
        
        let priorBounds: CGRect     = self.tableView!.bounds
        let fittedSize: CGSize      = self.tableView!.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.tableView!.contentSize.height))
        let pdfPageBounds: CGRect   = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
        let pdfData: NSMutableData  = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        self.tableView!.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let date = Date().formatted(date: .abbreviated, time: .omitted)
        let documentsFileName = documentDirectories! + "/" + "\(petName)_" + "\(date)" + ".pdf"
        pdfData.write(toFile: documentsFileName, atomically: true)
        
        let fileURL = URL(fileURLWithPath: documentsFileName)
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //    TableViewCell to PDF and present sharesheet
    
    func shareTVCPDF(petName: String, need: String, cell: UITableViewCell) {
       
        let pdfPageBounds = cell.bounds
        let pdfData       = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        UIGraphicsGetCurrentContext()?.translateBy(x: -cell.frame.origin.x, y: -cell.frame.origin.y)
        cell.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let date = Date().formatted(date: .abbreviated, time: .omitted)
        let pdfFileName = documentDirectories! + "/" + "\(petName)/\(need)_" + "\(date)" + ".pdf"
        pdfData.write(toFile: pdfFileName, atomically: true)
        
        let fileURL = URL(fileURLWithPath: pdfFileName)
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}

//if let cell = sender.superview?.superview as? UITableViewCell {
//
//    shareTVCPDF(cell: cell)
//}
