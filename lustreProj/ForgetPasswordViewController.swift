//
//  ForgetPasswordViewController.swift
//  lustreProj
//
//  Created by Shahad X on 14/07/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

class ForgetPassword: UIViewController {

    @IBOutlet weak var Email: UITextField!
    
    
    @IBAction func Next(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: Email.text! ) { error in
               
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
