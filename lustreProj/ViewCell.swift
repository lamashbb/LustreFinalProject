//
//  ViewCell.swift
//  lustreProj
//
//  Created by Shahad X on 02/07/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {

    @IBOutlet weak var cellBody: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var priice: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var InstName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var fav: UIButton!
    var delegate: ProgramCellDelegate?
   
    var cellBodyFunction: ((Any) -> Void)?
    var rateButtonFunction: ((Any) -> Void)?
    
    @IBAction func cellBodyClicked(_ sender: Any) {
        self.cellBodyFunction!(self)
    }
    
    @IBAction func rateButtonClicked(_ sender: Any) {
        self.rateButtonFunction?(self)

    }
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
