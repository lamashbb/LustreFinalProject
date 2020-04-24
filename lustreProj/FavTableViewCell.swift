//
//  FavTableViewCell.swift
//  lustreProj
//
//  Created by Raghad Alfhaid on 28/02/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Pimage: UIImageView!
    @IBOutlet weak var Pname: UILabel!
    @IBOutlet weak var Pdate: UILabel!
    @IBOutlet weak var Iname: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var Pprice: UILabel!
    @IBOutlet weak var age: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
