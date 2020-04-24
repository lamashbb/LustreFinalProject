//
//  Log In.swift
//  lustreProj
//
//  Created by Shahad X on 30/05/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseAuth



class Log_In: UIViewController , UITextFieldDelegate   {

    
    
    
    
    @IBOutlet weak var LogInLabel: UILabel!
      
      @IBOutlet weak var emailTextField: UITextField!
      
      @IBOutlet weak var PasswordTextField: UITextField!
   
      
      @IBAction func ForgotPassword(_ sender: UIButton) {
    }
    
      @IBOutlet weak var SignInButton: UIButton!
    

    @IBOutlet weak var RegisterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        setSignInButton(enabled: false)
        emailTextField.delegate = self
        PasswordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        PasswordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        self.emailTextField.delegate = self
        self.PasswordTextField.delegate = self
        
       
       
            //view.addSubview(activityView)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidLoad()
        emailTextField.becomeFirstResponder()
     /*   NotificationCenter.default.addObserver(self, selector: keyboardWillAppear, name: UIResponder.keyboardWillShowNotification, object:nil)*/
        print("IMMM HEEREEE")
       
            
    }

        
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
           emailTextField.becomeFirstResponder()
        }
 override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       emailTextField.resignFirstResponder()
      PasswordTextField.resignFirstResponder()
       NotificationCenter.default.removeObserver(self)
   }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return.lightContent
        }
}
   
    func setSignInButton(enabled:Bool){
                if enabled{
                    SignInButton.alpha = 1.0
                   SignInButton.isEnabled = true
                }else{
                    SignInButton.alpha=0.5
                    SignInButton.isEnabled = false
                }
            }
      
    
    
    @objc func handleSignIn(){
        guard   let Email1 = emailTextField.text else{return}
        guard  let Password1 = PasswordTextField.text else{return}
      
     
                 
              Auth.auth().signIn(withEmail: Email1, password: Password1) { user, error in
               // && (user?.user.isEmailVerified)!
                if error == nil && user != nil  {
                          self.dismiss(animated: false, completion: nil)
                        print("success login !!!!!!!!!")
                    state = .loggedIn
                    print(state)
                    print("state is ")
                   
                    self.setSignInButton(enabled: true)
                  
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondViewController = storyboard.instantiateViewController(withIdentifier: "TabHome") as UIViewController
                    TableViewController.favSelected = 0
                    print("the fav selcted is changed to ", TableViewController.favSelected)
                 //self.navigationController?.pushViewController(secondViewController, animated: true)
                    self.present(secondViewController, animated: true, completion: nil)
                    return
                      } else {
                        
                
                        print("Faild !!!!!!!!!")
                    self.displayMyAlert(userMessage: " Sorry ! your Email or password wrong ")
                        print(error!.localizedDescription)

                          
                      }
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
    
    func resetForm() {
          let alert = UIAlertController(title: "Error logging in", message: nil, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
          
          setSignInButton(enabled: true)
          SignInButton.setTitle("Next", for: .normal)
     }
 
   
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTextField.text
        let password = emailTextField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setSignInButton(enabled: formFilled)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        emailTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
        
        switch textField {
        case emailTextField:
           emailTextField.resignFirstResponder()
            PasswordTextField.becomeFirstResponder()
            break
        case  PasswordTextField:
            handleSignIn()
            break
        default:
            break
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
      
      
  
    
    
}

