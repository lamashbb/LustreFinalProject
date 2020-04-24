//
//  jj.swift
//  lustreProj
//
//  Created by Shahad X on 26/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//
import UIKit
import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

class BrowseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var programimage: UIImageView!
    @IBOutlet weak var programName: UILabel!
    
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var nameIns: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    //var delegate: ProgramCellDelegate?
    
    
      // static var isSelected = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToFav(_ sender: UIButton) {
     //delegate?.didTapaddToFav(title: "test")
       // ProgramTableViewCell.isSelected = false
        
       // home.addedToFav(sender)
        
       
        if sender.isSelected {
            sender.isSelected = false
                     
        }
        else{
            sender.isSelected = true
        }
       
        
    }
    
}
