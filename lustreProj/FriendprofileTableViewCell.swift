//
//  FriendprofileTableViewCell.swift
//  lustreProj
//
//  Created by ghaida habes on 01/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit

class FriendprofileTableViewCell: UITableViewCell {


        @IBOutlet weak var Friendimage: UIImageView!
        @IBOutlet weak var FriendInterest: UILabel!
        @IBOutlet weak var FriendNameField: UILabel!
        @IBOutlet weak var FollowButton: UIButton!
        @IBOutlet weak var FriendUserName: UILabel!
       var FollowButtonFunction: ((Any) -> Void)?

    @IBAction func FolloeButtonaction(_ sender: Any) {
         self.FollowButtonFunction!(self)
        }
    @IBOutlet weak var ChildrenName: UILabel!
    @IBOutlet weak var ChildrenBirthdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 }

}
