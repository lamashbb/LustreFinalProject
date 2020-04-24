//
//  ProfilePageViewController.swift
//  lustreProj
//
//  Created by ghaida habes on 26/01/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

struct Friends {
    static var FriendName = ""
    static var FriendInterest = ""
    static var FriendUserName = ""
    static var FriendUID = ""
    static var FriendURL = ""
}

class ProfilePageViewController: UIViewController {
    let cellId = "cellId"
   static var Friends2Array = [Friendsobj]()
    static var filteredUsers = [Friendsobj?]()
    static var usersInfoFD = [Friendsobj]()
    @IBOutlet weak var addchildplus: UIButton!
    @IBOutlet weak var addchildlabel: UILabel!
    var searchActive : Bool = false
    @IBOutlet weak var searchBar: UISearchBar!
    static var FriendName = ""
    static var FrindInterest = ""
    static var FriendUserName = ""
    static var FriendImageURL = ""
    static var UserDateOfBirth = ""
    static var UserGender = ""
    @IBOutlet weak var ProfileUserImageView: UIImageView!
    //    connect
    @IBOutlet weak var FollowinrequestView: UIView!
    @IBOutlet weak var requestButton: UIButton!
    var user : Friendsobj?
    var clicked = false

    override func viewDidLoad(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector (logIn))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector (LogOut))
            super.viewDidLoad()
        
       switch state {
          case .unregistered:
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let secondViewController = storyboard.instantiateViewController(withIdentifier: "GoToSignIn") as UIViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
//        self.navigationItem.leftBarButtonItem = nil
//        self.navigationItem.rightBarButtonItem = nil
          case .loggedIn :
            self.navigationItem.rightBarButtonItem = nil
            searchBar.delegate = self
              ckeckIfUserIsLoggedIn()
              loadinfo()
              loadFriend()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewTapped(gesture:)))
            FollowinrequestView.addGestureRecognizer(tapGesture)
            FollowinrequestView.isUserInteractionEnabled = true
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
    
//
//    @IBAction func LogOut(_ sender: Any) {
//        do {
//        try  Auth.auth().signOut()
//            state = .unregistered
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondViewController = storyboard.instantiateViewController(withIdentifier: "TabHome") as UIViewController
//         print(state)
//            print("log out ??")
//            present(secondViewController, animated: true, completion: nil)
//        }
//        catch {
//        print(" can  not log out ")
//        }}
//
  
    
 var childreen = [Child]()
 var intersest = [Interest]()
 var index = 0
    
    @IBOutlet weak var seg: UISegmentedControl!
    @IBAction func switchCustomTable(_ sender: UISegmentedControl) {}
    @IBOutlet weak var TableView: UITableView!
    @IBAction func valuChange(_ sender: UISegmentedControl) {
        if seg.selectedSegmentIndex == 0 {
           index = 0
    
            TableView.reloadData()
        }
       if seg.selectedSegmentIndex == 1 {
           index = 1
        TableView.reloadData()
        }
        
    }
    let childreen2 = ["noura", "latifa"]
    lazy var rowToDisplay = childreen2
    @IBOutlet weak var FullName: UILabel?
    @IBOutlet weak var InterestCat : UILabel!
    @IBOutlet weak var Edit: UIButton!
    @IBOutlet weak var Birthdate: UILabel!
    static var searchBarStaticText = ""



   @objc func ViewTapped(gesture: UIGestureRecognizer)  {
        if (gesture.view) != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let secondViewController = storyboard.instantiateViewController(withIdentifier: "FollowingRequestViewController") as UIViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
     func loadFriend(){
        ProfilePageViewController.Friends2Array.removeAll()
           print("here in loadfriend before calling")
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("Friends").queryOrdered(byChild: "UserName").observe(.childAdded, with:  { (snapshot) in
                   if let dect = snapshot.value as? NSDictionary{
                       let friendNameDect = dect["frindName"] as! String
                       let userNameDect = dect["UserName"] as! String
                       let FriendinterestDect = dect["Interest"] as! String
                       let status = dect["Status"] as! String
                       let frienduid = dect["UserId"] as! String
                       let friendURL = dect["ImageURL"] as! String

                       print(friendNameDect)
                       print("here i printed the friend name")
                       if status == "Accepted" {
                       let frind2 = Friendsobj(name: friendNameDect, interest: FriendinterestDect, userName: userNameDect, status: status, frienduid: frienduid, friendURL: friendURL)
                       print(frind2.name)
                       ProfilePageViewController.Friends2Array.append(frind2)
                        self.TableView.reloadData()
                       }
                   }}, withCancel: nil)
       } // End of load friend function

  
     func loadinfo(){
        print("hiiiiii in profile ")
        if Auth.auth().currentUser?.uid == nil {
                   perform(#selector (handleLogout), with: nil, afterDelay: 0 )
                   print("user is nil ")
               }else {
    FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child(("Childreen")).observeSingleEvent(of: .value, with: {(snapshot) in
                  print(snapshot)
                   if let dic = snapshot.value as? NSDictionary{
                       for each in dic {
                           print(each.key ?? "No data")
                         let child1 = Child()
                           child1.name = (each.value as! NSDictionary)["Name"]  as! String
                           child1.birthDate = (each.value as! NSDictionary)["Birthdate"] as! String
                           child1.gender = (each.value as! NSDictionary)["Gender"] as! String
                            self.childreen.append(child1)
                         self.navigationItem.title = dic["UserName"] as? String
                            }
                    self.TableView.reloadData()
                   }} , withCancel: nil)
        }
        
    } // End of load Info function
    
    func loadInterst(){
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child(("Interst")).observeSingleEvent(of: .value, with: {(snapshot) in
                     print(snapshot)
                  if let dic = snapshot.value as? [String : AnyObject ]{
                    var  art = dic["Art"]  as! String
                    var educ = dic["Education"]  as! String
                    var   food = dic["Food&Drinks"]  as! String
                    var  sport  = dic["Sport"]  as! String
                    var   lifeStyle = dic["LifeStyle"]  as! String
                    if art != "x" { self.InterestCat.text =  self.InterestCat.text! + art } else{ art = "" }
                    if educ != "x" { self.InterestCat.text =  self.InterestCat.text! + educ } else{ educ = "" }
                    if  food != "x" { self.InterestCat.text =  self.InterestCat.text! + food } else{ food = "" }
                    if sport != "x" { self.InterestCat.text =  self.InterestCat.text! + sport } else{sport = "" }
                    if lifeStyle != "x" { self.InterestCat.text =  self.InterestCat.text! + lifeStyle } else{lifeStyle = ""}
                    // here concat the interst togather
                    self.InterestCat.text = art  + educ + food + sport + lifeStyle
                            print("this is your interest")
                            print(art + educ + food + sport + lifeStyle)
                          }} , withCancel: nil)
        } // End of loadInterest() function
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
     } // End of addNavBarImage() function
    static var profileName = ""
    static var profileUsername = ""
    static var profileInterest = ""
    static var profileUID = ""
    static var profileImageURL = ""
    func ckeckIfUserIsLoggedIn(){
        print("i can reach the method from program page ")
       if Auth.auth().currentUser?.uid == nil {
            perform(#selector (handleLogout), with: nil, afterDelay: 0 )
            print("user is nil ")
        }else {
            print("i can reach the else stat from program page ")

        FirbaseRef.Users.child((Auth.auth().currentUser!.uid)).observeSingleEvent(of: .value, with: {(snapshot) in
                print("whyyyyyyyyy?????????????")
                print(snapshot)
                if let dic = snapshot.value as? [String : AnyObject ]{
                    let firstname = dic["FirstName"]as? String
                    let lastName = dic["LastName"]as? String
                    self.FullName?.text =  firstname! + " " + lastName!
                    self.Birthdate?.text = dic["Birthdate"]as? String
                    ProfilePageViewController.UserDateOfBirth = (dic["Birthdate"]as? String)!
                    ProfilePageViewController.UserGender = (dic["Gender"]as? String)!
                    ProfilePageViewController.profileName = firstname! + " " + lastName!
                    ProfilePageViewController.profileUID = (dic["UserId"] as? String)!
                    ProfilePageViewController.profileUsername = (dic["UserName"] as? String)!
                    ProfilePageViewController.profileImageURL = ((dic["ImageURL"] as? String)!)
                    do {
                    let fileUrl = URL(string:  ProfilePageViewController.profileImageURL)
                        let data = try Data(contentsOf: fileUrl!)
                        self.ProfileUserImageView.image = UIImage(data: data)
                    }
                    catch{
                            print(error)
                    }
                    self.loadInterst()
            }
         }, withCancel: nil)
      }
    } // End of ckeckIfUserIsLoggedIn() function


    // hide profile
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
        } catch let logoutError{
            print(logoutError)
        }
    } // End of handleLogout() function


    var friend1 : Friendsobj?
    var Fullname1 = ""
    var interest1 = ""
    var counter = 0
    var FriendID = ""
    var FriendURL = ""

  func loadFriendfromDatabase(searchText: String){
     ProfilePageViewController.usersInfoFD.removeAll()
     self.friend1 = Friendsobj( name: "x", interest: "x",  userName: "x", status: "x", frienduid: "x", friendURL: "x")
     FirbaseRef.Users.observe( .childAdded , with: {(snapshot) in
           if let dic = snapshot.value as? NSDictionary {
                 print(dic["UserName"] as? String as Any)
                 print("iam here in the method dddd")
                     guard let userNameforCompare = dic["UserName"] as? String
                         else { print ("username")
                             return }
                     let searchbaerText = searchText
                     print(userNameforCompare)
                     print(searchbaerText)
                    if(searchbaerText == userNameforCompare){
                     print("hi in equality statement")
                 // HERE LOADING THE FRIENDS DATA TO THE TABLE VIEW
                  guard let firstname = dic["FirstName"] as? String
                                                      else {print ("friend name")
                                                          return
                                                  }
                 guard let lastName = dic["LastName"] as? String
                                          else {print( "User Name")
                                              return
                                      }
                 guard let friendUid = dic["UserId"] as? String
                                         else {print( "friend id")
                                             return
                                     }
                    guard let ImageURL = dic["ImageURL"] as? String
                                        else {print( "URL")
                                                return
                                            }

                     ProfilePageViewController.FriendName = firstname + " " + lastName
                     self.Fullname1 = firstname + " " + lastName
                     ProfilePageViewController.FriendUserName = userNameforCompare
                     self.FriendID = friendUid
                     ProfilePageViewController.friendUID = self.FriendID
                    ProfilePageViewController.FriendImageURL = ImageURL
                    self.FriendURL = ImageURL
        FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("Interst")).observeSingleEvent(of: .value, with: {(snapshot) in
                                 print(snapshot)
                                 if let dic = snapshot.value as? [String : AnyObject] {
                                    var art   = dic["Art"]  as! String
                                    var educ  = dic["Education"]  as! String
                                    var food  = dic["Food&Drinks"]  as! String
                                    var sport = dic["Sport"]  as! String
                                    var lifeStyle = dic["LifeStyle"]  as! String
                                    if  art   != "x" { self.InterestCat.text =  self.InterestCat.text! + art  } else{ art   = ""}
                                    if  educ  != "x" { self.InterestCat.text =  self.InterestCat.text! + educ } else{ educ  = ""}
                                    if  food  != "x" { self.InterestCat.text =  self.InterestCat.text! + food } else{ food  = ""}
                                    if  sport != "x" { self.InterestCat.text =  self.InterestCat.text! + sport} else{ sport = ""}
                                    if  lifeStyle != "x" { self.InterestCat.text =  self.InterestCat.text! + lifeStyle} else{ lifeStyle = ""}
                      ProfilePageViewController.FrindInterest = art  + educ + food + sport + lifeStyle
                      self.interest1 = art  + educ + food + sport + lifeStyle
                                     }} , withCancel: nil)
                     self.friend1 = Friendsobj( name: self.Fullname1 , interest: self.interest1,  userName:  userNameforCompare, status: "", frienduid: self.FriendID , friendURL: self.FriendURL )
                             print("iprinted the name upupupupup")
                        ProfilePageViewController.usersInfoFD += [self.friend1!]
                        self.TableView.reloadData()
                 }
             ProfilePageViewController.searchActive = true
             print("iprintedwww the name upupupupup")
          }
         }, withCancel: nil)
    
    }} // End of class


extension ProfilePageViewController: UITableViewDataSource , UITableViewDelegate, UISearchBarDelegate{
    static var searchActive: Bool = false
          
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
              ProfilePageViewController.searchActive = true
      }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
               searchBar.endEditing(true)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          if self.index == 0 {
            addchildplus.isHidden = false
            addchildlabel.isHidden = false
           return childreen.count
          }
          else {
            addchildplus.isHidden = true
            addchildlabel.isHidden = true
              if ProfilePageViewController.searchActive {
                return ProfilePageViewController.usersInfoFD.count
              } else{
              print("here i am in friendsarray count")
              print(ProfilePageViewController.searchActive)
              return ProfilePageViewController.Friends2Array.count
              }
          }
      }  //End of tableView(numberOfRowsInSection) function

  
          static var friendUID = ""
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               print("hi 3")
               let Fcell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? FriendprofileTableViewCell
               if self.index == 0 {
                   addchildplus.isHidden = false
                   addchildlabel.isHidden = false
                   Fcell?.Friendimage.isHidden = true
                   print(ProfilePageViewController.searchActive)
                   print("here in children switch")
                   Fcell?.FriendNameField.text = childreen[indexPath.row].name
                   Fcell?.FriendUserName.text  = childreen[indexPath.row].gender
                   Fcell?.FollowButton.isHidden = true
                   Fcell?.FriendInterest.isHidden = true
                   Fcell?.textLabel?.layer.shadowColor = (UIColor(red: 1.000, green: 0.435, blue: 0.412, alpha: 1.0)).cgColor
                   Fcell!.backgroundColor = UIColor.white
                   return Fcell! }
               else {
                   addchildplus.isHidden = true
                   addchildlabel.isHidden = true
                   Fcell?.Friendimage.isHidden = false
                   print("THE VALUE OF THE SEARCH ACVTIVE")
                   print(ProfilePageViewController.searchActive)
                   if ProfilePageViewController.searchActive && searchBar.text != "" {
                       print(ProfilePageViewController.searchActive)
                     user = ProfilePageViewController.usersInfoFD[indexPath.row]
                     Fcell?.FriendNameField.text = ProfilePageViewController.usersInfoFD[indexPath.row].name
                     Fcell?.FriendUserName.text = ProfilePageViewController.usersInfoFD[indexPath.row].userName
                     Fcell?.FriendInterest.text = ProfilePageViewController.usersInfoFD[indexPath.row].interest
                     Fcell?.Friendimage?.image = nil
                                       Fcell?.tag += 1
                                       print("The Friend URL", ProfilePageViewController.usersInfoFD[indexPath.row].friendURL)
                                        let img = ProfilePageViewController.usersInfoFD[indexPath.row].friendURL
                                           getImage(url: img) { photo in
                                                     if photo != nil {
                                                       if Fcell!.tag == Fcell!.tag {
                                                             DispatchQueue.main.async {
                                                               Fcell?.Friendimage!.image = photo
                                                             }
                                                         }
                                                         else{
                                                           Fcell?.Friendimage!.image = UIImage(named: "nophoto")
                                                         }
                                                     }
                                                 }
                                       
                    
                                var frienduserName = ""
                                for n in ProfilePageViewController.Friends2Array{
                                    print("leleleleleel")
                                    print(n.userName)
                                    print(ProfilePageViewController.usersInfoFD[indexPath.row].userName)
                                      frienduserName = n.userName
                                 if ProfilePageViewController.usersInfoFD[indexPath.row].userName == frienduserName{
                                          Fcell?.FollowButton.isHidden = true
                                          break
                                     }
                                     else{
                                       Fcell?.FollowButton.isHidden = false
                                     }
                                } // End of for loop for Friend2Array
                      print(Fcell?.FriendNameField.text! as Any)
                      print("after all the strange things u did")
                    Fcell?.FollowButtonFunction = { sender in
                        print("BUtton Clicked")
                              Friends.FriendName = ProfilePageViewController.FriendName
                              Friends.FriendInterest = ProfilePageViewController.FrindInterest
                              Friends.FriendUserName = ProfilePageViewController.FriendUserName
                              Friends.FriendUID = ProfilePageViewController.friendUID
                        Friends.FriendURL = ProfilePageViewController.FriendImageURL
                        let values = ["frindName": Friends.FriendName , "Interest": Friends.FriendInterest , "UserName": Friends.FriendUserName , "Status": "Waiting","UserId": Friends.FriendUID , "ImageURL": Friends.FriendURL] as [String : Any]
                            print("print the id *********")
                        let valuesf = ["frindName": ProfilePageViewController.profileName , "Interest": ProfilePageViewController.profileInterest , "UserName":  ProfilePageViewController.profileUsername , "Status": "NotAccepted", "UserId": ProfilePageViewController.profileUID , "ImageURL" : ProfilePageViewController.profileImageURL ]
                            print("THE IDEEESSSS ARREEE COMMINNGGG")
                            print(ProfilePageViewController.friendUID)
                            print(Friends.FriendUID)
                            FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("Friends").childByAutoId().setValue(values)
                            FirbaseRef.Users.child(ProfilePageViewController.friendUID).child("Friends").childByAutoId().setValue(valuesf)
                        print("before button follow")
                        Fcell?.FollowButton.setTitle("Followed", for: .normal)
                        print("after button follow")
                        Fcell?.FollowButton.backgroundColor = UIColor.gray
                        print("last button follow")
                        print(values)
                        print(valuesf)
                        return
                    }
                   }
                   else if !ProfilePageViewController.searchActive {
                    addchildplus.isHidden = true
                     addchildlabel.isHidden = true
                     Fcell?.Friendimage.isHidden = false
                       print(ProfilePageViewController.searchActive)
                       user = ProfilePageViewController.Friends2Array[indexPath.row]
                      Fcell?.FriendInterest.text = ProfilePageViewController.Friends2Array[indexPath.row].interest
                      Fcell?.FriendUserName.text = ProfilePageViewController.Friends2Array[indexPath.row].userName
                      Fcell?.FriendNameField.text = ProfilePageViewController.Friends2Array[indexPath.row].name
                    Fcell?.Friendimage?.image = nil
                                       Fcell?.tag += 1
                                       let img = ProfilePageViewController.Friends2Array[indexPath.row].friendURL
                                            getImage(url: img) { photo in
                                                      if photo != nil {
                                                        if Fcell!.tag == Fcell!.tag {
                                                              DispatchQueue.main.async {
                                                                Fcell?.Friendimage!.image = photo
                                                              }
                                                          }
                                                          else{
                                                            Fcell?.Friendimage!.image = UIImage(named: "nophoto")
                                                          }
                                                      }
                                                  }
                                       
                      Fcell?.FollowButton.isHidden = true
                   }}
                    return Fcell! }
    
    
    
    func getImage(url: String, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if error == nil {
                completion(UIImage(data: data!))
            } else {
                completion(nil)
            }
        }.resume()
    }

           func filterContent(searchText:String){
               print("hi 5")
               ProfilePageViewController.filteredUsers = ProfilePageViewController.usersInfoFD.filter({ (user) -> Bool in
                   let username = user.userName
                    print(ProfilePageViewController.searchActive)
                    print("in filter content function")
                   let returnValue = (username.lowercased() as AnyObject).contains(searchText.lowercased())
                   return returnValue
               })
               } // End of filterContent()
           
         
         func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
             print("hi4")
              ProfilePageViewController.searchActive = true
             //Updata search result
               if searchText.count == 0{
               ProfilePageViewController.searchActive = false
               print("hi in searchBar function if searchbar is nil")
               print(ProfilePageViewController.searchActive)
               TableView.reloadData()
                } else {
               ProfilePageViewController.searchBarStaticText = searchText
               print( ProfilePageViewController.searchBarStaticText)
               loadFriendfromDatabase(searchText: searchText)
               filterContent(searchText: searchText as String)
               print(ProfilePageViewController.searchActive)
               print("hi in searchBar function if searchbar is not nul")
              }
             }// end of searchBar() function
             
              // THIS PAGE NOT IN SHAHAD VERSION DO IT
              func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              print("hi 6")
              let vc = (storyboard?.instantiateViewController(identifier: "FrriendProfileViewController") as? FrriendProfileViewController)!
              // here he used navigation bar why i don's know !!!!
               if self.index == 0 {
                   vc.Friendfullname = self.childreen[indexPath.row].name
                   vc.Friendusername  = self.childreen[indexPath.row].gender
                   vc.FriendInterest = ""
                   self.navigationController?.pushViewController(vc, animated: true)
              }
               else{
                   vc.Friendfullname = ProfilePageViewController.Friends2Array[indexPath.row].name
                   vc.Friendusername = ProfilePageViewController.Friends2Array[indexPath.row].userName
                   vc.FriendInterest = ProfilePageViewController.Friends2Array[indexPath.row].interest
                   print("print the information u want to send to the other page")
                   print(ProfilePageViewController.FriendName)
                   self.navigationController?.pushViewController(vc, animated: true)
               }
        }
         
         func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
         if editingStyle == .delete{
             
             if self.index == 0 {
                     childreen.remove(at: indexPath.row)
                     tableView.deleteRows(at: [indexPath], with: .bottom)
                        }
             else{
                 let friendTodeleteUID = ProfilePageViewController.Friends2Array[indexPath.row].frienduid
                //Delete the friend from my friend list
                 FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("Friends")).observe(.childAdded){ (snapshot) in
                     if let dict = snapshot.value as? NSDictionary{
                         let friendID = dict["UserId"]  as! String
                         if friendID == friendTodeleteUID{
                             snapshot.ref.removeValue()
                             return
                         }}}
//                // Delete me from the friend's list
//                FirbaseRef.Users.child(friendTodeleteUID).child(("Friends")).observe(.childAdded){ (snapshot) in
//                                    if let dict = snapshot.value as? NSDictionary{
//                                        let friendID = dict["UserId"]  as! String
//                                        if friendID ==  ProfilePageViewController.profileUID{
//                                            snapshot.ref.removeValue()
//                                            return
//                        }}}
                
                 ProfilePageViewController.Friends2Array.remove(at: indexPath.row)
                 tableView.deleteRows(at: [indexPath], with: .bottom)
      } } }

} // End of extension


    

