//
//  AddChild.swift
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

class AddChild: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

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
                     selection = pickerData[row]
                    GenderChild.text = selection
                     
                 }
          @IBOutlet weak var NameChild: UITextField!
          @IBOutlet weak var GenderChild: UITextField!
          @IBOutlet weak var BirthDateChild: UITextField!
          @IBOutlet weak var AddChildButton: UIButton!
          @IBOutlet weak var NextButton: UIButton!
    
          var selection : String?
             
         
            let datePicker = UIDatePicker()
    
    
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
                BirthDateChild.delegate = self as? UITextFieldDelegate
                BirthDateChild.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
                
                BirthDateChild.inputView = datePicker
                datePicker.datePickerMode = .date
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
                let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                toolbar.setItems([flaxSpace,doneButton], animated: true)
                BirthDateChild.inputAccessoryView = toolbar
                
                createPicker()
                createToolBar()
                
              // here if he click on next
                NextButton.addTarget(self, action: #selector(FillChildInfo), for: .touchUpInside)
              // here if he clicks on add
                AddChildButton.addTarget(self, action: #selector(FillChildInfo), for: .touchUpInside)
            }
            
     @objc func FillChildInfo(){
    childArray.countChildreen = childArray.countChildreen + 1

     let user1 = Child()
       user1.name = NameChild.text!
       user1.birthDate = BirthDateChild.text!
       user1.gender = GenderChild.text!
        print("In add child 1111")
        print(user1.name)
        print("this is the date")
        print(user1.birthDate)
        childArray.childreen.insert(user1, at: ChildInfo.counter)

     ChildInfo.counter = ChildInfo.counter+1
           print("Now count ====")
           print( childArray.arrayCount)
        
    }
            @objc func doneAction(){
                
                getDateFromPicker()
                view.endEditing(true)
            }
            func getDateFromPicker(){
                
                 let dateFormatter = DateFormatter()
                       dateFormatter .dateFormat="MM/dd/yyyy"
                BirthDateChild.text=dateFormatter.string(from: datePicker.date)
            }
            
            
            let pickerData = [ "Girl" , "Boy"]
              
            func createToolBar(){
                let toolBar = UIToolbar()
                toolBar.sizeToFit()
                let doneButton = UIBarButtonItem(title: " Done ", style: .plain, target: self, action: #selector (done))
                toolBar.setItems([doneButton], animated: false)
                toolBar.isUserInteractionEnabled = true
                let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                toolBar.setItems([flaxSpace,doneButton], animated: true)
                GenderChild.inputAccessoryView = toolBar
            }
            @objc func done(){
            
                view.endEditing(true)
            }
            
            @objc func textFieldChanged(_ target:UITextField) {
                    let date = BirthDateChild.text
                   
                   
                 //  setSignUpButton(enabled: formFilled)
               }
    
              func createPicker(){
                  
             let GenderPicker = UIPickerView()
                  GenderPicker.delegate = self
                
                  GenderChild.inputView = GenderPicker
          }
                
    


     
}
