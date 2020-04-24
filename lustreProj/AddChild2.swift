//
//  AddChild2ViewController.swift
//  lustreProj
//
//  Created by Shahad X on 14/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit

class AddChild2 : UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

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
      @IBOutlet weak var NextButton2 : UIButton!

      var selection : String?
         
     
        let datePicker = UIDatePicker()
        override func viewDidLoad() {
            super.viewDidLoad()
            
            BirthDateChild.delegate = self as? UITextFieldDelegate
             BirthDateChild.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
            createPicker()
            createToolBar()
            
            BirthDateChild.inputView = datePicker
            datePicker.datePickerMode = .date
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
            let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolbar.setItems([flaxSpace,doneButton], animated: true)
            BirthDateChild.inputAccessoryView = toolbar
           
            
          
            NextButton2.addTarget(self, action: #selector(FillChildInfo), for: .touchUpInside)
            // here if he clicks on add child
            AddChildButton.addTarget(self, action: #selector(FillChildInfo), for: .touchUpInside)
        }
    
    @objc func textFieldChanged(_ target:UITextField) {
         let date = BirthDateChild.text
        
        
      //  setSignUpButton(enabled: formFilled)
    }
        
 @objc func FillChildInfo(){
    
   childArray.countChildreen = childArray.countChildreen + 1
    
   guard  let name = NameChild.text else{return}
   guard  let gender = GenderChild.text else{return}
   guard  let date = BirthDateChild.text else{return}
    let user1 = Child()
    user1.name = name
    user1.birthDate = date
    user1.gender = gender
    
    print("how much capacity")
    print(childArray.countChildreen)
   
    
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
        
        
          func createPicker(){
              
         let GenderPicker = UIPickerView()
              GenderPicker.delegate = self
            
              GenderChild.inputView = GenderPicker
      }
            


}
