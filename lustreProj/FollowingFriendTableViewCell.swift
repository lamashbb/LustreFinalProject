//
//  FollowingFriendTableViewCell.swift
//  lustreProj
//
//  Created by ghaida habes on 10/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit

class FollowingFriendTableViewCell: UITableViewCell {
    @IBOutlet weak var FriendName: UILabel!
    @IBOutlet weak var FriendUserName: UILabel!
    @IBOutlet weak var FriendImage: UIImageView!
    @IBOutlet weak var AcceptButton: UIButton!
    @IBOutlet weak var DeclineButton: UIButton!
    var acceptButtonFunction: ((Any) -> Void)?
    var declineButtonFunction: ((Any) -> Void)?

    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        self.acceptButtonFunction!(self)
    }
    
    @IBAction func declineButtonPressed(_ sender: Any) {
        self.declineButtonFunction!(self)
    }
    
    
//
//    @objc func acceptButtonPressed(sender: Any){
//        self.acceptButtonFunction!(self)
//    }
//    @objc func declineButtonPressed(sender: Any) {
//        self.declineButtonFunction!(self)
//    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
