//
//  FavouritePageViewController.swift
//  lustreProj
//
//  Created by ghaida habes on 26/01/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import Foundation

class FavouritePageViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
     static var favProgram = [programs] ()
     static var Indexing = 0
      var progName = [String]()
    

    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector (logIn))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector (LogOut))
        super.viewDidLoad()
        addNavBarImage()
           if(TableViewController.favSelected == 2){
                    print("printed fav ?????????")
                }
        SwitchViewController()
        switch state {
                      case .unregistered:
                          self.navigationItem.leftBarButtonItem = nil
                    
                            return
                          
                      case .loggedIn :
                          self.navigationItem.rightBarButtonItem = nil
        
        
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
    
    
    
    
    
    
     func SwitchViewController(){
                switch state {
                case .unregistered:
                    print(" Nooooo user in fav")
                    doNOTHING()

                case .loggedIn :
                    print(" there is a ussserrrin fav ")
                        loadinfo()
                    tableview.allowsMultipleSelection = true


                }
        }
        func doNOTHING(){
            print("don't do anything")
            
        }
        
        func loadinfo() {
    //        FavouritePageViewController.favProgram.removeAll()
            print("count in fav is", FavouritePageViewController.favProgram.count)
            print("hiiiiii in fav finally ")
             FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("Favorite")).observe(.childAdded, with: {(snapshot) in
                print(snapshot, "snapshot printed in fav")

                                 if let dic = snapshot.value as? NSDictionary{
                                    print(dic ,"dic printed in fav")
                                   let name1 = dic["ProgramName"] as! String
                                   let Iname = dic["InstitutionName"] as! String
                                   let Age1 = dic["Age"] as! String
                                   let gender1 = dic["Gender"] as! String
                                   let price1 = dic["Price"] as! String
                                   let Date1 = dic["Sdate"] as! String
                                   let picture = dic["photo"] as! String
                                   let details1 = dic["details"] as! String
                                   let time1 = dic["time"] as! String
                                   let max = dic["Maxnumber"] as! String
                                   let minAge = dic["MinAge"] as! String
                                   let maxAge = dic["MaxAge"] as! String
                                   let id = dic["id"] as! String
                                   let date2 = dic["Edate"] as! String
                                   


                                    let prog = programs(name: name1, price:price1 , details: details1 , instName: Iname , date: Date1 , age: Age1 , gender: gender1 , time: time1 , photo: picture, max: max, minAge: minAge , maxAge: maxAge , id : id, Edate: date2)
                                    print("mission done")

                                    FavouritePageViewController.self.favProgram.append(prog)
                                    for n in FavouritePageViewController.self.favProgram {
                                        print(n.name, "i can print the name")
                                    }
                                        self.tableview.reloadData()

                                 
                                   
                                   
                                    
                                    

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FavouritePageViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print("i can reach this step in tv")

        return FavouritePageViewController.favProgram.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFav", for: indexPath) as! FavTableViewCell
        
        cell.Pname?.text = FavouritePageViewController.favProgram [indexPath.row].name
        cell.Iname?.text = FavouritePageViewController.favProgram [indexPath.row].instName
        cell.Pprice?.text = FavouritePageViewController.favProgram [indexPath.row].price
        cell.Pdate.text = FavouritePageViewController.favProgram[indexPath.row].Sdate
        cell.age?.text = FavouritePageViewController.favProgram[indexPath.row].age
        cell.gender?.text = FavouritePageViewController.favProgram[indexPath.row].gender
          
          //image
          cell.Pimage.image = nil
          cell.tag += 1
        let img = FavouritePageViewController.favProgram[indexPath.row].phote
          getImage(url: img) { photo in
              if photo != nil {
                  if cell.tag == cell.tag {
                      DispatchQueue.main.async {
                          cell.Pimage.image = photo
                      }
                  }
                  else{
                         cell.Pimage.image = UIImage(named: "nophoto")
                  }
              }
          }
       
        return cell
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
    // FavSegu
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        FavouritePageViewController.Indexing = indexPath.row
        performSegue(withIdentifier: "FavSegu", sender: self)
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let programDeleted = FavouritePageViewController.favProgram[indexPath.row].id

        print(indexPath.row , "### to delete ###")
        if (editingStyle == .delete){
           print("inside if")
            FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("Favorite")).observe(.childAdded){ (snapshot) in
                print("raghhfafghjdkl;", snapshot)
                if let dic = snapshot.value as? NSDictionary{
                    print("367654qqascg",dic)
                    let name1 = dic["id"] as! String
                    self.progName.append(name1)
                    for n in self.progName {
                        
                        print(name1, "i can print the name345")
                        if (name1 == programDeleted){
                            print("hello ##&&&&&")
                            snapshot.ref.removeValue()
                            return

                        }
                                                 
                    }
                }
                
            }
                
                
            
            FavouritePageViewController.favProgram.remove(at: indexPath.row)
            print(indexPath.row , "*****to delete *****")
            self.tableview.reloadData()

        }
       
        
        
    }
}



