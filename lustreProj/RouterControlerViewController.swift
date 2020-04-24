//
//  RouterControlerViewController.swift
//  lustreProj
//
//  Created by Shahad X on 16/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseAuth

class RouterControlerViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        Auth.auth().signIn( withCustomToken: Auth.auth().currentUser!.uid) { user, error in
                          if error == nil && user != nil {
                              self.dismiss(animated: false, completion: nil)
                            print("success login !!!!!!!!!")
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let signUpVC = storyboard.instantiateViewController(identifier: "profilePage")
                            self.present(signUpVC, animated: true, completion: nil)
                            
                            
                            
                          } else {
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let signUpVC = storyboard.instantiateViewController(identifier: "Log_In")
                            self.present(signUpVC, animated: true, completion: nil)
                           
                             error!.localizedDescription

                              
                          }
                      }
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
