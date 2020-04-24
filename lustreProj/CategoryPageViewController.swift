//
//  CategoryPageViewController.swift
//  lustreProj
//
//  Created by Raghad Alfhaid on 25/01/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

class CategoryPageViewController: UIViewController {
    static var ImageURL = ""
    @IBOutlet weak var ButtonDis: UIButton!

    @IBAction func NextButtonClicked() {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                             let secondViewController = storyboard.instantiateViewController(withIdentifier: "TabHome") as UIViewController
                                 present(secondViewController, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonDis.isEnabled = false
                
        // this call  method create user
        ButtonDis.addTarget(self, action: #selector(CreateUser), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
      @IBAction func sport(_ sender: UIButton) {
           if sender.isSelected  {
               sender.isSelected = false
           
           }
           else{
               sender.isSelected = true
               ButtonDis.isEnabled = true
               Interest.sport = " Sport ,"
           }
       }
       
       @IBAction func education(_ sender: UIButton) {
           if sender.isSelected  {
               sender.isSelected = false
           }
           else{
               sender.isSelected = true
               ButtonDis.isEnabled = true
               Interest.education = "education ,"
           }
       }
       
       @IBAction func food(_ sender: UIButton) {
           if sender.isSelected  {
               sender.isSelected = false
               
               
           }
           else{
               sender.isSelected = true
               ButtonDis.isEnabled = true
            Interest.food = "food & drink ,"
           }
       }
       
       @IBAction func art(_ sender: UIButton) {
           if sender.isSelected  {
               sender.isSelected = false
           }
           else{
               sender.isSelected = true
               ButtonDis.isEnabled = true
            Interest.Art = "Art ,"

           }
       }
       
       @IBAction func lifestyle(_ sender: UIButton) {
           if sender.isSelected  {
               sender.isSelected = false
           }
           else{
               sender.isSelected = true
               ButtonDis.isEnabled = true
               Interest.lifeStyle = "lifeStyle ,"
           }
       }

    @objc func CreateUser(){
        
           
              Auth.auth().createUser(withEmail: UserInfo.email , password: UserInfo.password){ (user, error) in
                        if user != nil {
                                  print("Create User")
                                 self.AddtoDatabase()
                                 self.sendEmailVerification()
                }
                
                
                        else{
                
                   print("there is an errrrrorrrrrr!!!!!!!!!!!!!!!!!")
                            print(error!.localizedDescription)}
                  
              }
        
    }
    
 

    func AddtoDatabase(){
              UserInfo.Uid = Auth.auth().currentUser!.uid
                guard let imageSelected = UserInfo.image else {
                    print("Avatar is nil")
                        return
                }
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4)
                    else {
                    return
                }
                let StorageRef = Storage.storage().reference(forURL: "gs://lustregp.appspot.com")
                let storageProfileRef = StorageRef.child("User'sProfileImages").child(UserInfo.Uid)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                storageProfileRef.putData(imageData, metadata: metadata, completion:
                    { (StorageMetadata, error) in
                    if error != nil{
                        print(error?.localizedDescription)
                        return
                    }
                storageProfileRef.downloadURL(completion: { (url, error) in
                         if let metaImageUrl = url?.absoluteString{
                             print("The Image url", metaImageUrl)
                             CategoryPageViewController.ImageURL = metaImageUrl
            let values = [ "Email": UserInfo.email, "password": UserInfo.password ,"FirstName" : UserInfo.FirstName, "LastName" : UserInfo.Lastname , "UserName": UserInfo.username , "Gender" : UserInfo.gender, "Birthdate" : UserInfo.date , "UserId" : UserInfo.Uid , "Long" : UserInfo.long , "Lati" : UserInfo.lati , "MaximumDis" : UserInfo.MaximumDis , "timer" : UserInfo.timer , "ImageURL" : metaImageUrl ] as [String : Any]
                 FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").setValue(values)
                         }
                     })
                })
             
               print("I'm heeeere ")
        
        self.AddChildtoDatabase()

        
    }
    func sendEmailVerification(){
        Auth.auth().currentUser?.sendEmailVerification(completion: {(error) in
            guard error == nil else {
                print ("we got an error with the email")
                return
            }
            print("we sent the verification")
        })
    }
    
    func AddChildtoDatabase(){
      
        print("innnnn child add")
      
        if childArray.countChildreen > 0 {
        for n in 0...childArray.countChildreen {
            let child = childArray.childreen[n]
            if child == nil {return }
            let name1 = child!.name
            let birthdate1 = child!.birthDate
            let gender1 = child!.gender
        // here to fill information
         let values = [ "Name" : name1 , "Gender" : gender1 , "Birthdate" : birthdate1] as [String : Any]
            // childreen.name1
            FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("Childreen").childByAutoId().setValue(values)
        // to update index for new child
        childArray.arrayCount =  childArray.arrayCount+1
           
        print(" childArray isss arrayCount ")
            print(childArray.arrayCount)
            } }
        else {
            print("there is no childreen")
        }
           
           self.AddInterest()
       

}
    
    func displayMyAlert(userMessage:String){
        let alertController = UIAlertController(
            title: "Error",
            message: userMessage,
            preferredStyle: UIAlertController.Style.alert
        )

      
        let confirmAction = UIAlertAction(
         title: "OK", style: UIAlertAction.Style.default);

        alertController.addAction(confirmAction)
       

         present(alertController, animated: true, completion: nil)
     }
     
    
    func AddInterest(){
        var  educ = ""
        var  art = ""
        var food = ""
        var sport = ""
        var lifeStyle = ""
        
            if Interest.Art != ""{
               art = Interest.Art
            }
            if Interest.education != ""{
             educ = Interest.education
                       }
            if Interest.food != ""{
                food = Interest.food
                       }
            if Interest.lifeStyle != ""{
                 lifeStyle = Interest.lifeStyle
                       }
            if Interest.sport != ""{
               sport = Interest.sport
                       }
            
        // here i fill interest in database
        
        let value = ["Art" : art , "Education" : educ , "Sport" : sport , "LifeStyle" : lifeStyle , "Food&Drinks" :food]
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("Interst").setValue(value)
        
        
    }
}
