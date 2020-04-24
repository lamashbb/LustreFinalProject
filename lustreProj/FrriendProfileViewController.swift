//
//  FrriendProfileViewController.swift
//  lustreProj
//
//  Created by ghaida habes on 02/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase


class FrriendProfileViewController: UIViewController {
static var index = 0
  //  @IBOutlet weak var TableView: UITableView!
    static var FriendProgram = [programs] ()
    @IBOutlet weak var TableView: UITableView!
    
//    var tableView: UITableView = UITableView()
        @IBOutlet weak var FriendFullname: UILabel!
        @IBOutlet weak var FriendUsername: UILabel!
        @IBOutlet weak var Friendsinterset: UILabel!
        
    @IBOutlet weak var FriendProfileImage: UIImageView!
    
        var image = UIImage()
        var Friendfullname = ""
        var Friendusername = ""
        var FriendInterest = ""
       static var friendID = ""
       static var FriendURL = ""
        var enter = true
        override func viewDidLoad() {
            super.viewDidLoad()
            TableView.delegate = self
            TableView.dataSource = self
            
            FriendFullname.text = Friendfullname
            FriendUsername.text = Friendusername
            Friendsinterset.text = FriendInterest
         
            print("the profile information")
            print(Friendfullname + Friendusername + FriendInterest)
            TableViewController.favSelected = -1
            loadFriendID()
            
    }
    
    func loadFriendID(){
        FrriendProfileViewController.FriendProgram.removeAll()
        var USername = ""
        var friendUID = ""
        var  FriendimageURL = ""
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child(("Friends")).observe(.childAdded, with: { (snapshot) in
           print("lalala")
            if let dict = snapshot.value as? NSDictionary{
                print(snapshot)
                USername = dict["UserName"] as! String
                friendUID = dict["UserId"] as! String
                FriendimageURL =  dict["ImageURL"] as! String
            if USername == self.Friendusername{
                FrriendProfileViewController.friendID = friendUID
                FrriendProfileViewController.FriendURL = FriendimageURL
                do {
                            let fileUrl = URL(string:                 FrriendProfileViewController.FriendURL)
                                let data = try Data(contentsOf: fileUrl!)
                                self.FriendProfileImage.image = UIImage(data: data)
                            }
                            catch{
                                    print(error)
                            }
                
                 print(FrriendProfileViewController.friendID)
                 print("here print the id of friend")
                self.loadinfo(friendUID: FrriendProfileViewController.friendID)
            return
        }}})
       
    }
    
    
    func loadinfo(friendUID: String){
        print("helo in friend's profile table view programs")
        print(friendUID)
        print("kokokokokokokokokokokokokokokokokoko")
     FirbaseRef.Users.child(friendUID).child(("MyPrograms")).observe(.childAdded){ (snapshot) in
            print("kokokokokokokokokokokokokokokokokoko2")
              if let dict = snapshot.value as? NSDictionary{
                let apearToFriend = dict["appearToFriends"] as! String
                print("kokokokokokokokokokokokokokokokokoko3")
               if apearToFriend == "Yes" {
                   let name1 = dict["ProgramName"] as! String
                   let Iname = dict["InstitutionName"] as! String
                   let Age1 = dict["Age"] as! String
                   let gender1 = dict["Gender"] as! String
                   let price1 = dict["Price"] as! String
                   let Date1 = dict["Sdate"] as! String
                   let picture = dict["photo"] as! String
                   let details1 = dict["details"] as! String
                   let time1 = dict["time"] as! String
                   let max = dict["Maxnumber"] as! String
                   let minAge = dict["MinAge"] as! String
                   let maxAge = dict["MaxAge"] as! String
                   let id = dict["id"] as! String
                   let date2 = dict["Edate"] as! String
                    let prog = programs(name: name1, price:price1 , details: details1 , instName: Iname , date: Date1 , age: Age1 , gender: gender1 , time: time1 , photo: picture, max: max, minAge: minAge , maxAge: maxAge , id : id, Edate: date2)
              FrriendProfileViewController.FriendProgram.append(prog)
                for n in FrriendProfileViewController.FriendProgram{
                    print(n.name, "here i print th ename of friend's program")
                }
                self.TableView.reloadData()
                }
                } // End of dect
            }
         } // End of loadInfo()
    } // End of class

extension FrriendProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if FrriendProfileViewController.FriendProgram.isEmpty {
              return 0
    } else{
        return FrriendProfileViewController.FriendProgram.count
        }
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // HHHEHEERRRREEEEEE THE LASSSTTTT FUUNNNCCCTTIIOONNNN
        print("helo in friend's profile table view ")
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath) as! FriendPrograminFriendProfileTableViewCell

cell2.programName?.text     = FrriendProfileViewController.FriendProgram[indexPath.row].name
cell2.institutionName?.text = FrriendProfileViewController.FriendProgram[indexPath.row].instName
cell2.gender?.text          = FrriendProfileViewController.FriendProgram[indexPath.row].gender
cell2.price?.text           = FrriendProfileViewController.FriendProgram[indexPath.row].price
cell2.date?.text            = FrriendProfileViewController.FriendProgram[indexPath.row].Sdate
cell2.age?.text             = FrriendProfileViewController.FriendProgram[indexPath.row].age
cell2.programImage.image    = nil
        
        let img = FrriendProfileViewController.FriendProgram[indexPath.row].phote
             getImage(url: img) { photo in
                 if photo != nil {
                     if cell2.tag == cell2.tag {
                         DispatchQueue.main.async {
                            cell2.programImage.image = photo
                             
                         }
                     }
                     else{
                            cell2.programImage.image = UIImage(named: "nophoto")
                     }
                 }
             }
               return cell2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FrriendProfileViewController.index = indexPath.row
        performSegue(withIdentifier: "programSegufriend", sender: self)
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
