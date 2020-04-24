//
//  nav.swift
//  lustreProj
//
//  Created by Shahad X on 26/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import Firebase
import Foundation
import FirebaseAuth




class nav: UINavigationController {
    var profile = ProfilePageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    switch state {
                case .unregistered:
                    print(" Nooooo user ????")
                    
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondViewController = storyboard.instantiateViewController(withIdentifier: "log") as UIViewController
                self.navigationController?.pushViewController(secondViewController, animated: true)
               return
              
                case .loggedIn :
                  
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                  let secondViewController = storyboard.instantiateViewController(withIdentifier: "pro") as UIViewController
                                  self.navigationController?.pushViewController(secondViewController, animated: true)
                
                
                  print("how many time!????????/!!")
                  print("did you call??")
                  return
   
}
    
  
         
     
     }




}
