//
//  RatingPopUpViewController.swift
//  lustreProj
//
//  Created by lam  on 4/24/20.
//  Copyright © 2020 lam . All rights reserved.
//


import UIKit
import Cosmos
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase
import FirebaseInstallations
import FirebaseCoreDiagnostics


class RatingPopupViewController: UIViewController {

    @IBOutlet weak var cosmos: CosmosView!
    
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var reviewTextField: UITextField!
    static var rText = ""
    static var starRating:String = ""
    static var currentDate:String = ""
    static var name:String = ""
    static var email:String = ""
    static var gender:String = ""
    static var birthday:String = ""
    static var img:String = ""
  
    override func viewDidLoad() {

        super.viewDidLoad()
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        RatingPopupViewController.currentDate = format.string(from: date)
        configureTextField()
        configureTapGesture()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        cosmos.didFinishTouchingCosmos = { rating in
            RatingPopupViewController.self.starRating = "\(rating)"
            print("ratinnnnng") //for console checking
            print(RatingPopupViewController.starRating) //for console checking
        }
        
        
    }
    
    func sendtToDB(){
            
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").observeSingleEvent(of: .value, with: {(snapshot) in
            if let dict = snapshot.value as? [String : AnyObject] {
                RatingPopupViewController.name = dict["FirstName"] as! String
                RatingPopupViewController.email = dict["Email"] as! String
                RatingPopupViewController.gender = dict["Gender"] as! String
                RatingPopupViewController.birthday = dict["Birthdate"] as! String
                RatingPopupViewController.img = dict["ImageURL"] as! String



                print("user's first name heeeeere", RatingPopupViewController.name)
                
                FirbaseRef.programs.observe(.childAdded, with: {(snapshot) in
                           
                    
                               
                        if let dic = snapshot.value as? [String : AnyObject]{
                          
                            
                            if (HistoryCurrentProgramViewController.pId == dic["id"] as? String) {
                              
                                let firstnameval = ["Name" : RatingPopupViewController.self.name]
                                let emailval = ["Email" : RatingPopupViewController.self.email]
                                let genderval = ["Gender" : RatingPopupViewController.self.gender]
                                let bdval = ["Birthdate" : RatingPopupViewController.self.birthday]
                                let imgval = ["ImageURL" : RatingPopupViewController.self.img]
                                  //   let name = ["Name" : self.name]
                                  
                                let progUniqueId = snapshot.ref.key!
                                print("program's unique id: ")
                                print(progUniqueId)
                                
                               
                                   FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(firstnameval)
                                FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(emailval)
                                FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(genderval)
                                FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(bdval)
                                FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(imgval)
                             
                             
                             
                            }
                       
                        }
                          
                        }
                        , withCancel: nil)
            }
            
            
        }, withCancel: nil)
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").observe(.childAdded, with: {(snapshot) in
         print("snapshot here")
         print(snapshot)
             
            
             print("programid")
             print(HistoryCurrentProgramViewController.pId)
         
              if let dic = snapshot.value as? [String : AnyObject ]{
                 if (HistoryCurrentProgramViewController.pId == dic["id"] as? String ){ //problem here, dic["id" = parent id of the first class in the list ony
                     
                     print("id=id")
                     print(dic["id"]!)
                     
                    let reviewval = ["Review" : RatingPopupViewController.self.rText]
                    let ratingval = ["Rating" : RatingPopupViewController.self.starRating]
                     let pId = snapshot.ref.key!
                     print("pId")
                     print(pId)
                     FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").child(pId).updateChildValues(reviewval as [AnyHashable : Any])
                     FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").child(pId).updateChildValues(ratingval)
                    
                    

                 }}}
           , withCancel: nil)
             FirbaseRef.programs.observe(.childAdded, with: {(snapshot) in
             print("programs snapshot here")
             print(snapshot)
                
         if let dic = snapshot.value as? [String : AnyObject]{
             print("programs id from history")
             print(HistoryCurrentProgramViewController.pId)
             
             if (HistoryCurrentProgramViewController.pId == dic["id"] as? String) {
                 print("program id = dicitonary id")
                 print(dic["id"]!)
               
              //snapshot for retrieving the name
                 
                   let date = ["Date" : RatingPopupViewController.currentDate]
                   let reviewval = ["Review" : RatingPopupViewController.rText]
                   let ratingval = ["Rating" : RatingPopupViewController.starRating]

                   //   let name = ["Name" : self.name]
                   
                 let progUniqueId = snapshot.ref.key!
                 print("program's unique id: ")
                 print(progUniqueId)
                 
                 FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(reviewval as [AnyHashable : Any])
                 FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(ratingval)
                 FirbaseRef.programs.child(progUniqueId).child("Ratings").child(Auth.auth().currentUser!.uid).updateChildValues(date)

              
             }
        
         }
           
         }
         , withCancel: nil)
    }
    

    private func configureTextField(){
        reviewTextField.delegate=self
    }

    
    
    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(RatingPopupViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        print("handle tap was called")
        view.endEditing(true)
    }

    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        print(reviewTextField.text!)
               RatingPopupViewController.self.rText=reviewTextField.text!
               sendtToDB()
               
               
    }
    
    

}

extension RatingPopupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
     }
}

