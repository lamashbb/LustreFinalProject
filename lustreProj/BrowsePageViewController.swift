//
//  BrowsePageViewController.swift
//  lustreProj
//
//  Created by ghaida habes on 26/01/2020.
//  Copyright © 2020 lam . All rights reserved.
//
import UIKit
import Firebase
import Foundation
import UserNotifications


class BrowsePageViewController: UIViewController {
static var Adult = 0
      var CategoryChosen = ""
    
    let cellId = "cell2"
    static var IndexChild = 0

      static var SearchProgram = [programs] ()
      
       static  var firebaseStorage: Storage?
    
    
    @IBAction func ViewAll(_ sender: Any) {
       
         self.loadAll()
    }
    
    @IBAction func Sport(_ sender: Any) {
         self.CategoryChosen = "Sport"
         self.loadinfo()
    }
    @IBAction func Art(_ sender: Any) {
          self.CategoryChosen = "Art"
          self.loadinfo()
        print("clicked ")
        


    }
    @IBAction func Food(_ sender: Any) {
          self.CategoryChosen = "Food"
         self.loadinfo()
    }
    @IBAction func LifeStyle(_ sender: Any) {
         self.CategoryChosen = "LifeStyle"
         self.loadinfo()
    }
    
    @IBAction func Education(_ sender: Any) {
          self.CategoryChosen = "Education"
         self.loadinfo()
    }
    
   var tableView1: UITableView  =   UITableView()

    override func viewDidLoad() {
        print("************* Hi in browse view controller *************")
        super.viewDidLoad()

        tableView1 = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        tableView1.delegate      =   self
        tableView1.dataSource    =   self
        
       
        
        
       // addNavBarImage()
       print("hii print the table ")
       print(tableView1)
        

        for n in BrowsePageViewController.SearchProgram {
            print(n.name , n.gender , "mission done")
            
        }
       
      
    }
    func loadAll(){
        
        BrowsePageViewController.SearchProgram.removeAll()
              FirbaseRef.programs.observe(.childAdded, with: {(snapshot) in
                          print(snapshot)
                         // (each.value as! NSDictionary)
                           if let dic = snapshot.value as? NSDictionary{
                              
                                    let name1 = dic["nameprogam"]  as! String
                                    let price1 = dic["Price"] as! String
                                    let details1 = dic["discussion"] as! String
                                    let inst1 = dic["name"] as! String //***
                                    let date1 = dic["StartDate"] as! String
                                    let age1 = dic["Age"] as! String
                                    let gender1 = dic["gender"] as! String
                                    let time1 = dic["starttime"] as! String
                                    // image
                                    let photoURL = dic["image"] as! String
                                    let max = dic["Maxnumber"] as! String
                                    let minAge = dic["MinAge"] as! String
                                    let maxAge = dic["MaxAge"] as! String
                                    let id = dic["id"] as! String
                                    let date2 = dic["EndDate"] as! String

                            


                            let prog1 = programs(name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL, max: max, minAge: minAge, maxAge: maxAge , id: id , Edate: date2)
                              
                                  
                                  if  dic["Age"] as! String == "child"{
                                    BrowsePageViewController.SearchProgram.append(prog1)
                                  }
                          
                               
                              for n in BrowsePageViewController.SearchProgram {
                              print("course name ")
                                  print(n.name)
                                                       }
                             

                              self.tableView1.reloadData()

                           }} , withCancel: nil)
        
        
        
    }
     func loadinfo(){
          
        BrowsePageViewController.SearchProgram.removeAll()
        FirbaseRef.programs.observe(.childAdded, with: {(snapshot) in
                    print(snapshot)
                   // (each.value as! NSDictionary)
                     if let dic = snapshot.value as? NSDictionary{
                        
                              let name1 = dic["nameprogam"]  as! String
                              let price1 = dic["Price"] as! String
                              let details1 = dic["discussion"] as! String
                              let inst1 = dic["name"] as! String //***
                              let date1 = dic["StartDate"] as! String
                              let age1 = dic["Age"] as! String
                              let gender1 = dic["gender"] as! String
                              let time1 = dic["starttime"] as! String
                              // image
                              let photoURL = dic["image"] as! String
                             let max = dic["Maxnumber"] as! String
                             let minAge = dic["MinAge"] as! String
                             let maxAge = dic["MaxAge"] as! String
                            let id = dic["id"] as! String
                        let date2 = dic["EndDate"] as! String


                        let prog1 = programs(name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL, max: max, minAge: minAge , maxAge: maxAge , id :id , Edate: date2)
                        
                            
                            if dic["category"]  as! String  == self.CategoryChosen && dic["Age"] as! String == "child"{
                              BrowsePageViewController.SearchProgram.append(prog1)
                            }
                    
                         
                        for n in BrowsePageViewController.SearchProgram {
                        print("course name ")
                            print(n.name)
                                                 }
                       

                        self.tableView1.reloadData()

                     }} , withCancel: nil)
         
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
   

}
extension BrowsePageViewController : UITableViewDataSource, UITableViewDelegate {


   
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi in method ")
        return BrowsePageViewController.SearchProgram.count
     }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

    let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2" , for: indexPath) as! BrowseTableViewCell
           print(" innnnn search ")
          
    cell2.programName?.text = BrowsePageViewController.SearchProgram[indexPath.row].name
    cell2.nameIns?.text = BrowsePageViewController.SearchProgram[indexPath.row].instName
    cell2.gender?.text = BrowsePageViewController.SearchProgram[indexPath.row].gender
    cell2.price?.text = BrowsePageViewController.SearchProgram[indexPath.row].price
    cell2.date?.text = BrowsePageViewController.SearchProgram[indexPath.row].Sdate
    cell2.age?.text = BrowsePageViewController.SearchProgram[indexPath.row].age
      
      //image
      cell2.programimage.image = nil
      cell2.tag += 1
    let img = BrowsePageViewController.SearchProgram[indexPath.row].phote
      getImage(url: img) { photo in
          if photo != nil {
              if cell2.tag == cell2.tag {
                  DispatchQueue.main.async {
                      cell2.programimage.image = photo
                      
                  }
              }
              else{
                     cell2.programimage.image = UIImage(named: "nophoto")
              }
          }
      }
  
         return cell2
         
     }
  
      
  func getImage(url: String, completion: @escaping (UIImage?) -> ()) {
      URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
          if error == nil {
              completion(UIImage(data: data!))
          } else {
              completion(nil)
          }
      }.resume()

  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      BrowsePageViewController.Adult = 0
      BrowsePageViewController.IndexChild = indexPath.row
      performSegue(withIdentifier: "Program", sender: self)

        }
   
  
   
     
 
}

