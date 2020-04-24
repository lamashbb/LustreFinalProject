//
//  CurrentProgram.swift
//  lustreProj
//
//  Created by Shahad X on 14/07/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import Foundation

class CurrentProgram  {
      var name : String
      var price : String
      var details : String
      var instName : String
      var date : String
      var age : String
      var gender : String
      var time : String
      var phote : String
      var id : String
    
    
      

     
      
    init(name: String, price: String ,details:String,instName: String, date: String, age: String, gender: String, time: String, photo: String , id : String){
          
          self.name = name
          self.price = price
          self.details = details
          self.instName = instName
          self.date = date
          self.age = age
          self.gender = gender
          self.time = time
          self.phote = photo
          self.id = id
          
          
      }
}

