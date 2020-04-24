//
//  BrowsePageForAdult.swift
//  lustreProj
//
//  Created by Shahad X on 28/06/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
import Firebase
import Foundation

class BrowsePageForAdult: UIViewController {

    
    var CategoryChosen = ""
     
     let cellId = "cell2"
    static var IndexAdult = 0

       static var SearchProgramForAdult = [programs] ()
    
    @IBAction func ViewAll(_ sender: Any) {
        self.loadAll()
    }
    
    
    
    @IBAction func sport(_ sender: Any) {
        CategoryChosen = "Sport"
        loadinfoForAdult()
    }
    
    
    
    @IBAction func Art(_ sender: Any) {
         CategoryChosen = "Art"
        loadinfoForAdult()
    }
    
    
    @IBAction func Cooking(_ sender: Any) {
        CategoryChosen =  "Food"
        loadinfoForAdult()
    }
    
    
    @IBAction func lifeStyle(_ sender: Any) {
         CategoryChosen =  "LifeStyle"
        loadinfoForAdult()
    }
    
    
    
    @IBAction func Education(_ sender: Any) {
         CategoryChosen = "Education"
        loadinfoForAdult()
    }
    
     var tableView: UITableView  =   UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       tableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
       tableView.delegate      =   self
       tableView.dataSource    =   self
    }
    func loadAll() {
        
        BrowsePageForAdult.SearchProgramForAdult.removeAll()
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


                                let prog1 = programs(name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL, max: max, minAge: minAge , maxAge: maxAge , id : id , Edate: date2)
                                 
                                     
               if  dic["Age"] as! String == "Adult"{
                   BrowsePageForAdult.SearchProgramForAdult.append(prog1)
                                     }
                             
                                  
                                 for n in BrowsePageForAdult.SearchProgramForAdult {
                                 print("course name ")
                                     print(n.name)
                                                          }
                                

                                 self.tableView.reloadData()

                              }} , withCancel: nil)
                  
                   }
        
    

    func loadinfoForAdult(){
            
        BrowsePageForAdult.SearchProgramForAdult.removeAll()
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



                        let prog1 = programs(name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL, max: max, minAge: minAge , maxAge: maxAge , id: id , Edate: date2)
                          
                              
        if dic["category"]  as! String  == self.CategoryChosen  && dic["Age"] as! String == "Adult"{
            BrowsePageForAdult.SearchProgramForAdult.append(prog1)
                              }
                      
                           
                          for n in BrowsePageForAdult.SearchProgramForAdult {
                          print("course name ")
                              print(n.name)
                                                   }
                         

                          self.tableView.reloadData()

                       }} , withCancel: nil)
           
            }

}

extension BrowsePageForAdult : UITableViewDataSource, UITableViewDelegate {


   
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi in method ")
        return BrowsePageForAdult.SearchProgramForAdult.count
     }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

    let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell3" , for: indexPath) as! BrowseTableViewCell
           print(" innnnn search ")
          
    cell2.programName?.text = BrowsePageForAdult.SearchProgramForAdult[indexPath.row].name
    cell2.nameIns?.text = BrowsePageForAdult.SearchProgramForAdult[indexPath.row].instName
    cell2.gender?.text = BrowsePageForAdult.SearchProgramForAdult[indexPath.row].gender
    cell2.price?.text = BrowsePageForAdult.SearchProgramForAdult[indexPath.row].price
    cell2.date?.text = BrowsePageForAdult.SearchProgramForAdult[indexPath.row].Sdate
    cell2.age?.text = BrowsePageForAdult.SearchProgramForAdult[indexPath.row].age
      
      //image
      cell2.programimage.image = nil
      cell2.tag += 1
    let img = BrowsePageForAdult.SearchProgramForAdult[indexPath.row].phote
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          BrowsePageViewController.Adult = 1
          BrowsePageForAdult.IndexAdult = indexPath.row
           performSegue(withIdentifier: "Program", sender: self)

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
  
  
  
   
     
 
}

