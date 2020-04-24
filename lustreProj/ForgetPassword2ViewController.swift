//
//  ForgetPassword2ViewController.swift
//  lustreProj
//
//  Created by Shahad X on 01/09/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit

class ForgetPassword2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Login(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "GoToSignIn") as UIViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
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
