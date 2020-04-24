//
//  FollowinRequestTableViewController.swift
//  lustreProj
//
//  Created by ghaida habes on 10/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

class FollowinRequestTableViewController: UIViewController {
 // weak var delegate: TableViewCellDelegate?
var FriendRequestNA = [Friendsobj]()
var FriendRequestWF = [Friendsobj]()
static var friendTUID = ""
var index = 0

    @IBOutlet weak var FollowSegment: UISegmentedControl!
    @IBAction func followSegmented(_ sender: Any) {
        if FollowSegment.selectedSegmentIndex == 0 {
            index = 0
        }
        if FollowSegment.selectedSegmentIndex == 1{
            index = 1
        }
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriend()
    }
static var frienduserName = ""
static var friendUID = ""
    func loadFriend(){
        var frind2 = Friendsobj(name: "", interest: "", userName: "", status: "", frienduid: "", friendURL: "")
    FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("Friends").queryOrdered(byChild: "UserName").observe(.childAdded, with:  { (snapshot) in
    if let dect = snapshot.value as? NSDictionary{
        let friendNameDect = dect["frindName"] as! String
        let userNameDect = dect["UserName"] as! String
        let FriendinterestDect = dect["Interest"] as! String
        let status = dect["Status"] as! String
        let friendUID = dect["UserId"] as! String
        let friendImageURL = dect["ImageURL"] as? String

        print(friendNameDect)
           print("here i printed the friend name")
        if status == "NotAccepted" {
            frind2 = Friendsobj(name: friendNameDect, interest: FriendinterestDect, userName: userNameDect, status: status, frienduid: friendUID, friendURL: friendImageURL!)
        print(frind2.name)
       self.FriendRequestNA.append(frind2)
       self.tableView.reloadData()
        }
        if status == "Waiting" {
            frind2 = Friendsobj(name: friendNameDect, interest: FriendinterestDect, userName: userNameDect, status: status, frienduid: friendUID, friendURL: friendImageURL!)
                  print(frind2.name)
              self.FriendRequestWF.append(frind2)
              self.tableView.reloadData()
         }
       }}, withCancel: nil)


       } // End of load friend function
}
    // MARK: - Table view data source

extension FollowinRequestTableViewController: UITableViewDataSource , UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == 1{
        return FriendRequestNA.count
        }
       else {
        return FriendRequestWF.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_id", for: indexPath) as? FollowingFriendTableViewCell
        if index == 1{
        cell?.AcceptButton.isHidden = false
        cell?.DeclineButton.isHidden = false
        cell?.AcceptButton.setTitle("Accept", for: .normal)
        cell?.DeclineButton.setTitle("Decline", for: .normal)
        cell?.FriendName.text = self.FriendRequestNA[indexPath.row].name
        cell?.FriendUserName.text = self.FriendRequestNA[indexPath.row].userName
        FollowinRequestTableViewController.friendTUID = self.FriendRequestNA[indexPath.row].frienduid
        FollowinRequestTableViewController.frienduserName = self.FriendRequestNA[indexPath.row].userName
            cell?.FriendImage?.image = nil
                cell?.tag += 1
                 let img = self.FriendRequestNA[indexPath.row].friendURL
                    getImage(url: img) { photo in
                              if photo != nil {
                                if cell!.tag == cell!.tag {
                                      DispatchQueue.main.async {
                                        cell?.FriendImage!.image = photo
                                      }
                                  }
                                  else{
                                    cell?.FriendImage!.image = UIImage(named: "nophoto")
                                  }
                              }
                          }
                                                
            
            
        cell?.acceptButtonFunction = { sender in
        print("hello in accept button function")
        // update the accepted friend fromn the current user data base
    FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("Friends")).observe(.childAdded){ (snapshot) in
                        if let dict = snapshot.value as? NSDictionary{
                          let friendID = dict["UserId"]  as! String
                          print("helo print the friend id")
                          print(self.FriendRequestNA[indexPath.row].frienduid)
                          if friendID == self.FriendRequestNA[indexPath.row].frienduid {
                              print(friendID)
                              print("the accepted friend id 1")
                            snapshot.ref.updateChildValues(["Status" : "Accepted"])
                            self.FriendRequestNA.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .bottom)
                                return
                      }}}
          // update the current user from the accepted friend data base
          FirbaseRef.Users.child(self.FriendRequestNA[indexPath.row].frienduid).child(("Friends")).observe(.childAdded){ (snapshot) in
            print("ijijijiji")
            if let dict = snapshot.value as? NSDictionary{
            let friendID = dict["UserId"]  as! String
                print("ijijijiji2")
                print(ProfilePageViewController.profileUID)
                print(friendID)
            if friendID == ProfilePageViewController.profileUID{
                    print(friendID)
                    print("the accepted friend id 2")
                        snapshot.ref.updateChildValues(["Status" : "Accepted"])
                return
            }}}
          //  ProfilePageViewController.loadFriend()
 }// end of accept action
      cell?.declineButtonFunction = { sender in
        // Delete the decline friend fromn the current user data base
         FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("Friends")).observe(.childAdded){ (snapshot) in
                        if let dict = snapshot.value as? NSDictionary{
                          let friendID = dict["UserId"]  as! String
                          print("helo print the friend id")
                          print(self.FriendRequestNA[indexPath.row].frienduid)
                          if friendID == self.FriendRequestNA[indexPath.row].frienduid {
                              print(friendID)
                              print("the declined friend id")
                              snapshot.ref.removeValue()
                              self.FriendRequestNA.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .bottom)
                                return
                      } } }
          // Delete the current user from the declined friend data base
          FirbaseRef.Users.child(self.FriendRequestNA[indexPath.row].frienduid).child(("Friends")).observe(.childAdded){ (snapshot) in
            if let dict = snapshot.value as? NSDictionary{
            let friendID = dict["UserId"]  as! String
            if friendID == ProfilePageViewController.profileUID{
                    print(friendID)
                    print("the declined friend id")
                      snapshot.ref.removeValue()
                      return
            }}}
        } // end of declined action
        //tableView.reloadData()
        }
        if index == 0{
            cell?.FriendName.text = self.FriendRequestWF[indexPath.row].name
            cell?.FriendUserName.text = self.FriendRequestWF[indexPath.row].userName
            cell?.FriendImage?.image = nil
                     cell?.tag += 1
                      let img = self.FriendRequestWF[indexPath.row].friendURL
                         getImage(url: img) { photo in
                                   if photo != nil {
                                     if cell!.tag == cell!.tag {
                                           DispatchQueue.main.async {
                                             cell?.FriendImage!.image = photo
                                           }
                                       }
                                       else{
                                         cell?.FriendImage!.image = UIImage(named: "nophoto")
                                       }
                                   }
                               }
            
            
            cell?.AcceptButton.isHidden = true
         //   cell?.DeclineButton.isHidden = true
          cell?.DeclineButton.setTitle("Followed", for: .normal)
            
          //   tableView.reloadData()
            
        }
   return cell!

    } // End of table view func
    func getImage(url: String, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if error == nil {
                completion(UIImage(data: data!))
            } else {
                completion(nil)
            }
        }.resume()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
        if index == 0{
            // Delete the deleted friend from the current user database
            let friendTodeleteUID = self.FriendRequestWF[indexPath.row].frienduid
            print("waiting friend to delete")
            print(friendTodeleteUID)
                         FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("Friends")).observe(.childAdded){ (snapshot) in
                             if let dict = snapshot.value as? NSDictionary{
                                 let friendID = dict["UserId"]  as! String
                                 if friendID == friendTodeleteUID{
                                     snapshot.ref.removeValue()
                                     return
                                 } } }
            // Remove this user from the deleted friend database
            FirbaseRef.Users.child(self.FriendRequestWF[indexPath.row].frienduid).child(("Friends")).observe(.childAdded){ (snapshot) in
                if let dict = snapshot.value as? NSDictionary{
                let friendID = dict["UserId"]  as! String
                if friendID == ProfilePageViewController.profileUID{
                        print(friendID)
                        print("the delted wating friend id")
                          snapshot.ref.removeValue()
                          return
                }}}
            
         self.FriendRequestWF.remove(at: indexPath.row)
         tableView.deleteRows(at: [indexPath], with: .bottom)
            
    } // end of if index statement
    } // End of editing style
    
   } // End of method commit .delete
} // End of class
