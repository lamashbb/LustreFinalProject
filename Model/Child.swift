//
//  Child.swift
//  lustreProj
//
//  Created by Shahad X on 14/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit

class Child: NSObject {

   var name = ""
   var birthDate = ""
   var gender = ""
    
    override init() {
        
    }
    
    init(name1 : String){
        self.name = name1
    }
    init(name : String , birthdate : String , gender : String) {
        self.name = name
        self.birthDate = birthdate
        self.gender = gender
        
    }
}
