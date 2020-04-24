//
//  ChildrenRegTableViewCell.swift
//  lustreProj
//
//  Created by Raghad Alfhaid on 04/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit

class ChildrenRegTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
