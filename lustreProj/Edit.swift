//
//  Edit.swift
//  lustreProj
//
//  Created by Shahad X on 19/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase


class Edit: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate{

    var selection : String?
    let pickerData = [ "Female" , "Male"]
    let datePicker = UIDatePicker()
  
    @IBOutlet weak var FirstName: UITextField!
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var Date: UITextField!
    
     var Gender = ""
     var Email = ""
  
    
    @IBOutlet weak var Update: UIButton!
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                          return 1
                      }
                      
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                          pickerData.count
                      }
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                          return pickerData[row]
                      }
func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                        
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
           
           
override func viewDidLoad() {
                       super.viewDidLoad()
                  
                


                        
                 Date.inputView = datePicker
                                      datePicker.datePickerMode = .date
                                      let toolbar = UIToolbar()
                                      toolbar.sizeToFit()
                                      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
                                      let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                                      toolbar.setItems([flaxSpace,doneButton], animated: true)
                                     Date.inputAccessoryView = toolbar
                      
                
                      
                       self.FirstName.delegate = self
                       self.LastName.delegate = self
                       self.UserName.delegate = self
                      
                       UpdateInfo()
                       //createPicker()
                      //createToolBar()
                     Update.addTarget(self, action: #selector(UdateDatabase), for: .touchUpInside)
                     }
           
          @objc func textFieldChanged(_ target:UITextField) {
                    let FirstName1 = FirstName.text
                    let LastName1 = LastName.text
                    let UserName1 = UserName.text
                   
                 //  setSignUpButton(enabled: formFilled)
               }
           
    func UpdateInfo(){
        
        FirbaseRef.Users.child(Auth.auth().currentUser!.uid).observeSingleEvent(of:.value, with: {(snapshot) in
                  print(snapshot)
                  if let dic = snapshot.value as? [String : AnyObject ]{
                    self.navigationItem.title = dic["UserName"] as? String
                      
                    self.FirstName.text = dic["FirstName"]as? String
                    self.LastName.text = dic["LastName"]as? String
                    self.Date.text = dic["Birthdate"]as? String
                    self.UserName.text = dic["UserName"]as? String
                    self.Gender = (dic["Gender"]as? String)!
                    self.Email = (dic["Email"]as? String)!
                      
          
                    
                  }
                  
                  
                  
              }, withCancel: nil)}
    @objc func UdateDatabase(){
        
        let values = ["FirstName" : FirstName.text, "LastName" : LastName.text , "UserName": UserName.text , "Gender" : Gender, "Birthdate" : Date.text ] as [String : Any]
                   FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").updateChildValues(values)
        
    }
           
@objc func done(){
                                  
getDateFromPicker()
view.endEditing(true)}
    
func getDateFromPicker(){
                                  
let dateFormatter = DateFormatter()
dateFormatter .dateFormat="MM/dd/yyyy"
Date.text=dateFormatter.string(from: datePicker.date) }
                              
                      
                             
                       
                     //
                     @objc func doneAction(){
                     
                         view.endEditing(true)
                     }
                     
        
       

         
           override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                 self.view.endEditing(true)
             }
             
             func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                 FirstName.resignFirstResponder()
                 LastName.resignFirstResponder()
                 UserName.resignFirstResponder()
               
                 return (true)
             }

                

       }

    
    

    


