//
//  ViewAll.swift
//  lustreProj
//
//  Created by Shahad X on 03/07/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//

import UIKit
 import Firebase
 import Foundation

class ViewAll: UIViewController {
// if index == 0 then in progs2 if index ==1 then in search
  static var index = 0
    // for all programs
  static var indexRow = 0
    // for search
  static var indexRow2 = 0

          
            
       
       var Search1: UISearchBar = UISearchBar()
        static var progs2 = [programs] ()
       
        static var  SearchNames = [programs]()
        var search = false
              
    @IBOutlet weak var Table: UITableView!
    

             override func viewDidLoad() {
//                     addNavBarImage()
//                     super.viewDidLoad()
//
//
//
//                    // addNavBarImage()
//                     loadinfo()
//

                 navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector (logIn))
                  navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector (LogOut))
                   super.viewDidLoad()
                      switch state {
                      case .unregistered:
                          self.navigationItem.leftBarButtonItem = nil
                      addNavBarImage()
                      loadinfo()
                       return
                          
                      case .loggedIn :
                          self.navigationItem.rightBarButtonItem = nil
                         addNavBarImage()
                         loadinfo()
                 }
    
    }
    @objc func logIn(){
          
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let secondViewController = storyboard.instantiateViewController(withIdentifier: "GoToSignIn") as UIViewController
          self.navigationController?.pushViewController(secondViewController, animated: true)
      }
      
      
      @objc func LogOut(_ sender: Any) {
          
          do {
              try  Auth.auth().signOut()
                                state = .unregistered
                               
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let secondViewController = storyboard.instantiateViewController(withIdentifier: "TabHome") as UIViewController
                                
                             print(state)
                                print("log out ??")
                                present(secondViewController, animated: true, completion: nil)
                                
                            }
                            catch {
                            print(" can  not log out ")
                            }
      }
      
                 
            func loadinfo(){
                     
                      FirbaseRef.programs.observe(.childAdded, with: {(snapshot) in
                       
                       
                                  if  let dict = snapshot.value as? NSDictionary{
                                 

                                      let name1 = dict["nameprogam"] as! String
                                      let price1 = dict["Price"] as! String
                                      let details1 = dict["discussion"] as! String
                                      let inst1 = dict["name"] as! String //***
                                      let date1 = dict["StartDate"] as! String
                                      let age1 = dict["Age"] as! String
                                      let gender1 = dict["gender"] as! String
                                      let time1 = dict["starttime"] as! String
                                      // image
                                     let photoURL = dict["image"] as! String
                                    let max = dict["Maxnumber"] as! String
                                    let minAge = dict["MinAge"] as! String
                                    let maxAge = dict["MaxAge"] as! String
                                    let id = dict["id"] as! String
                                    let date2 = dict["EndDate"] as! String



                                    let prog5 = programs( name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL, max: max, minAge: minAge , maxAge: maxAge , id: id , Edate: date2)
                                    ViewAll.progs2.append(prog5)
                                 
                                  

                                  }
                       
                       
                      for n in ViewAll.progs2 {
                       print("course name ,,, ")
                           print(n.name)
                                                }
                       
                        self.Table.reloadData()
                       
                          } , withCancel: nil)
                    
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
               
                    
                 
                 @IBAction func handleLogout(_ target: UIBarButtonItem) {
                      
                             do {
                                 try Auth.auth().signOut()
                                 dismiss(animated: true, completion: nil)
                             }
                             catch{
                               //  print("There was a problem signing out")
                             }
                         
                     
                     
                 }
    
}
extension ViewAll : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if search {
            print("in search count" )
            print(ViewAll.SearchNames.count)
            ViewAll.index = 1
            return ViewAll.SearchNames.count
        }
        else {
        print(" in table methood ")
         ViewAll.index = 0
        return ViewAll.progs2.count
        
        } }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hi ????????????????")
        let cellView = tableView.dequeueReusableCell(withIdentifier: "cellView" , for: indexPath) as! ViewCell
          
        
                   if search {
        
                    cellView.programName?.text = ViewAll.SearchNames[indexPath.row].name
                    cellView.age?.text = ViewAll.SearchNames[indexPath.row].age
                                cellView.date?.text = ViewAll.SearchNames[indexPath.row].Sdate
                                cellView.gender?.text = ViewAll.SearchNames[indexPath.row].gender
                                cellView.InstName?.text = ViewAll.SearchNames[indexPath.row].instName
                                cellView.priice?.text = ViewAll.SearchNames[indexPath.row].price
        
                                           cellView.imageView2.image = nil
                                                 cellView.tag += 1
                                                 let img = ViewAll.SearchNames[indexPath.row].phote
                                                 getImage(url: img) { photo in
                                                     if photo != nil {
                                                         if cellView.tag == cellView.tag {
                                                             DispatchQueue.main.async {
                                                               cellView.imageView2.image = photo
                                                                 
                                                             }
                                                         }
                                                         else{
                                                           cellView.imageView2.image = UIImage(named: "nophoto")
                                                         }
                                                     }
                                               }
        
                             
                            }
          
          
                   else {
            cellView.programName.text = ViewAll.progs2[indexPath.row].name
            cellView.age?.text = ViewAll.progs2[indexPath.row].age
            cellView.date?.text = ViewAll.progs2[indexPath.row].Sdate
            cellView.gender?.text = ViewAll.progs2[indexPath.row].gender
            cellView.InstName?.text = ViewAll.progs2[indexPath.row].instName
            cellView.priice?.text = ViewAll.progs2[indexPath.row].price
          
            cellView.imageView2.image = nil
                  cellView.tag += 1
                  let img = ViewAll.progs2[indexPath.row].phote
                  getImage(url: img) { photo in
                      if photo != nil {
                          if cellView.tag == cellView.tag {
                              DispatchQueue.main.async {
                                cellView.imageView2.image = photo
                              }
                          }
                          else{
                            cellView.imageView2.image = UIImage(named: "nophoto")
                          }
                      }
                    }}
        
        
        
        return cellView
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
        if ViewAll.index == 0 {
            ViewAll.indexRow = indexPath.row
            performSegue(withIdentifier: "programSegu", sender: self)}
        else {
            ViewAll.indexRow2 = indexPath.row
            performSegue(withIdentifier: "programSegu", sender: self)
            
        }
           
       }
    
    
    
}
extension ViewAll : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ViewAll.SearchNames = ViewAll.progs2.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased() })
    search = true
        print("in search ")
    self.Table.reloadData()
}
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         search = false
        searchBar.text = ""
        self.Table.reloadData()
    }

}

