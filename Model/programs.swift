//
//  programs.swift
//  lustreProj
//
//  Created by Shahad X on 17/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import Foundation

class programs  {
      var name : String
      var price : String
      var details : String
      var instName : String
      var age : String
      var gender : String
      var time : String
      var phote : String
      var max : String
      var minAge : String
      var maxAge : String
      var id :String
    var Edate :String
    var Sdate :String
      

     
      
    init(name: String, price: String ,details:String,instName: String ,date :String , age: String, gender: String, time: String, photo: String , max :String , minAge : String , maxAge : String , id :String , Edate :String ){
          
          self.name = name
          self.price = price
          self.details = details
          self.instName = instName
           self.Sdate = date
          self.age = age
          self.gender = gender
          self.time = time
          self.phote = photo
          self.max = max
          self.minAge = minAge
          self.maxAge = maxAge
          self.id = id
        self.Edate = Edate
     
      }
}
