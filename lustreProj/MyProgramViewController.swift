//
//  MyProgramViewController.swift
//  lustreProj
//
//  Created by lam  on 1/25/20.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit

class MyProgramViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        // Do any additional setup after loading the view.
    }
    
    
       func addNavBarImage(){
           let navController = navigationController!
           let image = UIImage(named: "Logo Red")
           let imageView = UIImageView(image: image)
           let bannerWidth = navController.navigationBar.frame.size.width
           let bannerHeight = navController.navigationBar.frame.size.height
           let bannerX = bannerWidth - (image?.size.width)!
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
