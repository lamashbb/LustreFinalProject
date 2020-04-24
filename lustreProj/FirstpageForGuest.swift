//
//  FirstpageForGuest.swift
//  lustreProj
//
//  Created by Shahad X on 01/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit

class FirstpageForGuest: UIViewController {

    @IBOutlet weak var SignIn: UIButton!
    @IBOutlet weak var SignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUp.layer.cornerRadius = 8
        SignIn.layer.cornerRadius = 8
      SignIn.layer.borderWidth = 0.9
       SignIn.layer.borderColor = (UIColor( red: 0.588, green: 0.808, blue:0.706, alpha: 1.0 )).cgColor
        SignUp.layer.borderWidth = 0.9
       SignUp.layer.borderColor = (UIColor( red: 0.588, green: 0.808, blue:0.706, alpha: 1.0 )).cgColor

        // Do any additional setup after loading the view.
    }
    
    func addNavBarImage() {
            let navController = navigationController!
            let image = UIImage(named: "Logo Red") //Your logo url here
            let imageView = UIImageView(image: image)
            let bannerWidth = navController.navigationBar.frame.size.width
            let bannerHeight = navController.navigationBar.frame.size.height
            let bannerX = bannerWidth  - (image?.size.width)!
            let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
            imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
            imageView.contentMode = .scaleAspectFit
            navigationItem.titleView = imageView
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
