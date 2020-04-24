//
//  TableViewController.swift
//  lustreProj
//
//  Created by Shahad X on 25/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
enum State {
      case unregistered
      case loggedIn
      //case sessionExpired(User)
  }
var state: State = .unregistered

class TableViewController: UITabBarController , UITabBarControllerDelegate{

    var profile = ProfilePageViewController()
    static var favSelected = 0
    var fav = FavouritePageViewController()
    


   
  

    @IBOutlet weak var LogOut: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

     
    
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        TableViewController.favSelected = tabBarController.selectedIndex
        print("Selected view controller", tabBarController.selectedIndex , "finally i find it")
        
        if tabBarController.selectedIndex == 4 {
          print("??????????????!!!!")
                 
             }

            
                       
                         
                     }
        
    
    
    }
    
    
    
    
    
    

 


