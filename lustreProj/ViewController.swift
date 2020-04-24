//
//  ViewController.swift
//  lustreProj
//
//  Created by lam  on 1/25/20.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseAuth



 

class ViewController: UIViewController , UITextFieldDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SwitchViewController()
        // Do any additional setup after loading the view.
    }
    func SwitchViewController(){
       
        switch state {
        case .unregistered:
            print(" Nooooo user")
            self.performSegue(withIdentifier: "GoToSignIn", sender: nil)

        case .loggedIn :
            print(" there is a ussserrr ")
            self.performSegue(withIdentifier: "GoToProfile", sender: nil)

       
            
        }
        
    
    }
    
    
    
}

