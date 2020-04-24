//
//  FriendPrograminFriendProfileTableViewCell.swift
//  lustreProj
//
//  Created by ghaida habes on 15/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit

class FriendPrograminFriendProfileTableViewCell: UITableViewCell {


        @IBOutlet weak var programImage: UIImageView!
        @IBOutlet weak var programName: UILabel!
        @IBOutlet weak var institutionName: UILabel!
        @IBOutlet weak var price: UILabel!
        @IBOutlet weak var date: UILabel!
        @IBOutlet weak var age: UILabel!
        @IBOutlet weak var gender: UILabel!
      //  @IBOutlet weak var fav: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
