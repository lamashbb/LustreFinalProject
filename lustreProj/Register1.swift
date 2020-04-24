//
import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase


class Register1: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate{
 
     var flag = false
    
  

    
    @IBOutlet weak var FirstName: UITextField!
    
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var Gender: UITextField!
    
    
    @IBOutlet weak var DataTextfield: UITextField!
    
    
    @IBAction func NextPage1(_ sender: Any) {
        
 checkUserNameAlreadyExist(newUserName: UserName.text!)
        Verfication(self)
        
    }
    
    
    @IBAction func AddChildButtun(_ sender: Any) {
checkUserNameAlreadyExist2(newUserName: UserName.text! )
       }
    
    func checkUserNameAlreadyExist2 (newUserName: String ){
        
        let ref = Database.database().reference()
                       ref.child("Users").queryOrdered(byChild:"UserName").queryEqual(toValue: newUserName)
                           .observeSingleEvent(of: .value, with: {(snapshot: DataSnapshot) in

                           if snapshot.exists() {
                               print("Username exist")
                             
                              self.displayMyAlert(userMessage: "Sorry , userName already exit")
                 
                           }
                           else {
                                print("Username available ")
                            self.handleSignUp2()
                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              let secondViewController = storyboard.instantiateViewController(withIdentifier: "AddChildId") as UIViewController
                                  print("go to add child ")
                              self.navigationController?.pushViewController(secondViewController, animated: true)
                              
                           }
                       })
        
        
    }
    
    func checkUserNameAlreadyExist(newUserName: String ) {

                 let ref = Database.database().reference()
                 ref.child("Users").queryOrdered(byChild:"UserName").queryEqual(toValue: newUserName)
                     .observeSingleEvent(of: .value, with: {(snapshot: DataSnapshot) in

                     if snapshot.exists() {
                         print("Username exist")
                       
                        self.displayMyAlert(userMessage: "Sorry , userName already exit")
           
                     }
                     else {
                          print("Username available ")
                        self.handleSignUp1()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let secondViewController = storyboard.instantiateViewController(withIdentifier: "GoogleMapId") as UIViewController
                    print(" go to google map  ")
                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        
                     }
                 })
             }
    
    
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
                   Gender.text = selection
                   
               }
    
    //var key:String!

   //  var ref: DatabaseReference!
    
  
    
    func Verfication(_ sender: Any) {
        let FirstName1 = FirstName.text
                     let LastName1 = LastName.text
                     let UserName1 = UserName?.text
                     let date = DataTextfield.text
                     //self.NextToRegister2.layer.cornerRadius = 8
                     if( FirstName1!.isEmpty || LastName1!.isEmpty || UserName1!.isEmpty || date!.isEmpty)
                     {
                         displayMyAlert(userMessage: "All fields are required")
                         return
                         
                 
        }
        
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
    
    
                
              
                var selection : String?
                let pickerData = [ "Female" , "Male"]
              let datePicker = UIDatePicker()

                  
override func viewDidLoad() {
super.viewDidLoad()
 

              
                
              
                             FirstName.delegate = self as? UITextFieldDelegate
                             LastName.delegate = self as? UITextFieldDelegate
                             UserName.delegate = self as? UITextFieldDelegate
                             Gender.delegate = self as? UITextFieldDelegate
                             DataTextfield.delegate = self as? UITextFieldDelegate
                             
                            FirstName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
                             LastName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
                            UserName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
                            Gender.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
                            DataTextfield.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
                  
                  createPicker()
                  createToolBar()
                               DataTextfield.inputView = datePicker
                               datePicker.datePickerMode = .date
                               let toolbar = UIToolbar()
                               toolbar.sizeToFit()
                               let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
                               let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                               toolbar.setItems([flaxSpace,doneButton], animated: true)
                              DataTextfield.inputAccessoryView = toolbar
               
            
                self.FirstName.delegate = self
                self.LastName.delegate = self
                self.UserName.delegate = self
                
                // fill  information if he click on next
                //NextPage.addTarget(self, action: #selector(handleSignUp1), for: .touchUpInside)
                // fill information if he click on add child
                //AddChildrenButton.addTarget(self, action: #selector(handleSignUp2), for: .touchUpInside)
                
                

              
               
    }
   
    
   @objc func textFieldChanged(_ target:UITextField) {
             let FirstName1 = FirstName.text
             let LastName1 = LastName.text
             let UserName1 = UserName.text
            
          //  setSignUpButton(enabled: formFilled)
    
    
                  
        }
    
    
    
              @objc func done(){
                           
                           getDateFromPicker()
                           view.endEditing(true)
                       }
                       func getDateFromPicker(){
                           
                            let dateFormatter = DateFormatter()
                                  dateFormatter .dateFormat="MM/dd/yyyy"
                           DataTextfield.text=dateFormatter.string(from: datePicker.date)
                       }
                       
                 func createPicker(){
                      
                 let GenderPicker = UIPickerView()
                      
                      GenderPicker.delegate = self
                      Gender.inputView = GenderPicker
              }
                        func createToolBar(){
                            let toolBar = UIToolbar()
                            toolBar.sizeToFit()
                            let doneButton = UIBarButtonItem(title: " Done ", style: .plain, target: self, action: #selector (doneAction))
                            toolBar.setItems([doneButton], animated: false)
                            toolBar.isUserInteractionEnabled = true
                            let flaxSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                            toolBar.setItems([flaxSpace,doneButton], animated: true)
                            Gender.inputAccessoryView = toolBar
                        }
              //
              @objc func doneAction(){
              
                  view.endEditing(true)
              }
              
 
    @objc func handleSignUp2(){
        
        childArray.countChildreen = childArray.countChildreen + 1
        
        UserInfo.FirstName = FirstName.text!
        UserInfo.Lastname = LastName.text!
        UserInfo.gender = Gender.text!
        UserInfo.date = DataTextfield.text!
        UserInfo.username = UserName.text!
        print("Successfully saved user to database.")
       
                   self.dismiss(animated: true, completion: nil)
             // })
                   print( UserInfo.FirstName)
             print("first name")
             print(" user email ")
             print(UserInfo.email)
        
    }

    @objc func handleSignUp1(){
       
     guard  let firstName = FirstName.text else{return}
     guard  let LastName1 = LastName.text else{return}
     guard  let UserName1 = UserName.text else{return}
     guard  let Gender1 = Gender.text else{return}
     guard  let date = DataTextfield.text else{return}
        
     
        UserInfo.FirstName = FirstName.text!
        UserInfo.Lastname = LastName.text!
        UserInfo.gender = Gender.text!
        UserInfo.date = DataTextfield.text!
        UserInfo.username = UserName.text!
     
        
        
              print("Successfully saved user to database.")
              self.dismiss(animated: true, completion: nil)
        // })
              print( UserInfo.FirstName)
        print("first name")
        print(" user email ")
        print(UserInfo.email)
        
        
        
            
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

