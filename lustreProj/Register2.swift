//
//  Register2.swift
//  lustreProj
//
//  Created by Shahad X on 30/05/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

struct FirbaseRef{
    static let  ref = Database.database().reference()
    static let Users = FirbaseRef.ref.child("Users")
    static let Children = FirbaseRef.ref.child("Children")
     static let programs = FirbaseRef.ref.child("Courses")
    static func Id (userId: String) -> DatabaseReference {
        return FirbaseRef.Users.child(userId)
    }
    
    
}

struct UserInfo{
       static var email = ""
       static var password = ""
       static var id = ""
       static var FirstName = ""
     static var Lastname = ""
    static var username = ""
    static var date = ""
    static var gender = ""
    static var Uid = ""
    // 0 for weekDay 1 for weekend
    static var WeekDay = ""
    // 0 for daytime 1 for evening
    static var dayTime = ""
    static var long = ""
    static var lati = ""
    static var MaximumDis = ""
    static var timer = "15"
    static var image: UIImage? = nil

}

struct childArray {
    static var countChildreen = 0
    static var childreen = [Child?](repeating: nil, count: countChildreen)
    // this to save index to next child
    static var arrayCount = 0
   
}
struct Interest{
    
   static var education = "x"
    static var food = "x"
     static var Art = "x"
     static var sport = "x"
     static var lifeStyle = "x"
    
}
struct ChildInfo{
    static var name = ""
    static var birthDate = ""
    static var gender = ""
    static var counter = 0 ;
}

class Register2: UIViewController , UITextFieldDelegate {


@IBOutlet weak var Email: UITextField!
    
@IBOutlet weak var Password: UITextField!
           
@IBOutlet weak var ConformedPassword: UITextField!
           
           
    
    @IBAction func Next(_ sender: Any) {
        let emailAddress = Email.text
        let flag = isValidEmailAddress(emailAddressString: emailAddress!)
        if flag {
            print("email address valid ")
        } else {
            self.displayMyAlert(userMessage: "Sorry , Email address not valid")
        }
        validate()
    }
    
    
    
    
    
    
    
    
var  imagePicker: UIImagePickerController!

    @IBOutlet weak var profileImageView: UIImageView!
  
  
    
    @objc func textFieldChanged(_ target:UITextField) {
          let Email1 = Email.text
        let Password1 = Password.text
        let ConformedPassword1 = ConformedPassword.text
          let formFilled = Email1 != nil && Email1 != "" && Password1 != nil && Password1 != "" && ConformedPassword1 != nil && ConformedPassword1 != ""
        //  setSignUpButton(enabled: formFilled)
      }
           

    
       override func viewDidLoad() {
           super.viewDidLoad()
   

      
        //setSignUpButton(enabled: false)
        Email.delegate = self as? UITextFieldDelegate
        Password.delegate = self as? UITextFieldDelegate
        ConformedPassword.delegate = self as? UITextFieldDelegate

        
        Email.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        Password.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        ConformedPassword.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
      let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        
           // Do any additional setup after loading the view.
          
              imagePicker = UIImagePickerController()
              imagePicker.allowsEditing = true
              imagePicker.sourceType = .photoLibrary
              imagePicker.delegate = self
         
        UserInfo.email = Email.text!
        UserInfo.password = Password.text!
        
       // handleSignUp()
         NextToHomePage.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        self.Email.delegate = self
        self.Password.delegate = self
        self.ConformedPassword.delegate = self
    }
    
              
    
    @IBOutlet weak var NextToHomePage: UIButton!
    
        @objc func openImagePicker(_ sender:Any) {
              // Open Image Picker
              self.present(imagePicker, animated: true, completion: nil)
          }
    
    func validate() {
              let Email1 = Email.text
              let Password1 = Password.text
              let ConformedPassword1 = ConformedPassword.text
            
              
              if( Email1!.isEmpty || Password1!.isEmpty || ConformedPassword1!.isEmpty )
              {
                  displayMyAlert(userMessage: "All fields are required")
                  return
                  
              }
        if (Password1 != ConformedPassword1 ){
            
            displayMyAlert(userMessage: "Please make sure your passwords match ")
            return } }
          
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
       func setSignUpButton(enabled:Bool){
           if enabled{
              NextToHomePage.alpha = 1.0
              NextToHomePage.isEnabled = true
           }else{
              NextToHomePage.alpha=0.5
            NextToHomePage.isEnabled = false
           }
       }
    @objc func handleSignUp(){
        
    
        guard   let Email1 = Email.text else{return}
        guard  let Password1 = Password.text else{return}
        guard  let ConformedPassword1 = ConformedPassword.text else{return}
        guard let image = profileImageView.image else { return }
       
        UserInfo.email = Email.text!
        UserInfo.password = Password.text!
     
        print("hii ")

        print(UserInfo.email)
               
      
        NextToHomePage.setTitle("Next", for: .normal)
  
        
    }

      func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
 



    }//for class








extension Register2: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
          if let imageselected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
               UserInfo.image = imageselected
               profileImageView.image = imageselected
               
           }
           if let OriginalImage = info[UIImagePickerController.InfoKey.originalImage ] as? UIImage{
               UserInfo.image = OriginalImage
               profileImageView.image = OriginalImage
          }

           picker.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           Email.resignFirstResponder()
           Password.resignFirstResponder()
           ConformedPassword.resignFirstResponder()
           return (true)
       }
  

}


