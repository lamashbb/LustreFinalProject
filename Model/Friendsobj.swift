//
//  Friendsobj.swift
//  lustreProj
//
//  Created by ghaida habes on 01/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit

class Friendsobj: NSObject {
            var name : String
            var interest : String
            var userName : String
            var status : String
            var frienduid : String
            var friendURL : String
          
    init(name: String, interest: String, userName : String, status : String, frienduid: String, friendURL : String ) {
           self.name = name
           self.interest = interest
           self.userName = userName
           self.status = status
           self.frienduid = frienduid
           self.friendURL = friendURL
          }
    
    
}
