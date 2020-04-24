//
//  Editf.swift
//  lustreProj
//
//  Created by Shahad X on 23/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

struct InterestUpdate{
    
   static var education = "x"
    static var food = "x"
     static var Art = "x"
     static var sport = "x"
     static var lifeStyle = "x"
    
}
  
class EditPassword_Interest: UIViewController {

  
    
    @IBAction func AddChild(_ sender: Any) {
        childArray.countChildreen = childArray.countChildreen + 1
    }
    
    
    
    
    
    
    @IBAction func UpdatePassword(_ sender: Any) {
        UpdatePass()
    }
    
    
    @IBAction func UpdateInterest(_ sender: Any) {
        
        UpdateInt()
    }
    
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var UpdateInterest: UIButton!
    
    
    @IBAction func sport(_ sender: UIButton) {
         if sender.isSelected  {
             sender.isSelected = false
         
         }
         else{
             sender.isSelected = true
             UpdateInterest.isEnabled = true
            InterestUpdate.sport = "Sport , "
         }
     }
     
     @IBAction func education(_ sender: UIButton) {
         if sender.isSelected  {
             sender.isSelected = false
         }
         else{
             sender.isSelected = true
             UpdateInterest.isEnabled = true
            InterestUpdate.education = "education ,"
         }
     }
     
     @IBAction func food(_ sender: UIButton) {
         if sender.isSelected  {
             sender.isSelected = false
             
             
         }
         else{
             sender.isSelected = true
             UpdateInterest.isEnabled = true
            InterestUpdate.food = "food & drink ,"
         }
     }
     
     @IBAction func art(_ sender: UIButton) {
         if sender.isSelected  {
             sender.isSelected = false
         }
         else{
             sender.isSelected = true
            UpdateInterest.isEnabled = true
            InterestUpdate.Art = "Art ,"

         }
     }
     
     @IBAction func lifestyle(_ sender: UIButton) {
         if sender.isSelected  {
             sender.isSelected = false
         }
         else{
             sender.isSelected = true
             UpdateInterest.isEnabled = true
            InterestUpdate.lifeStyle = "lifeStyle ,"
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
UpdateInt()
        
       //  UpdateInterest.addTarget(self, action: #selector(UpdateInt), for: .touchUpInside)
        //UpdatePassword.addTarget(self, action: #selector(UpdatePass), for: .touchDown)
        
    }
    
    @objc func UpdatePass(){
       
        let values = [ "password": password.text ] as [String : Any]
        Auth.auth().currentUser!.updatePassword(to: password.text as! String) { (error) in
      
            
        }
         
}
       @objc func UpdateInt(){
           
     
                    
                // here i fill interest in database
                
        let value = ["Art" : InterestUpdate.Art, "Education" : InterestUpdate.education, "Sport" : InterestUpdate.sport , "LifeStyle" : InterestUpdate.lifeStyle , "Food&Drinks" :  InterestUpdate.food]
                FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("Interst").updateChildValues(value)
                
    }

}
