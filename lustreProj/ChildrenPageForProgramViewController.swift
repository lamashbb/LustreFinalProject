
//
//  ChildrenPageForProgramViewController.swift
//  lustreProj
//
//  Created by Raghad Alfhaid on 04/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

class ChildrenPageForProgramViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Register: UIButton!
    static var childreen = [Child]()
    static var age = 0
    static var count = 0
    static var numOfChildren = 0
    static var childName = [String]()
    static var childrenNameArray = [String]()
    var prog = ProgramPageViewController()
    static var c = 0
    static var IDArray = [String]()


   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadinfo()
        print(ChildrenPageForProgramViewController.numOfChildren, "in childdd")
        


    }
    
    func loadinfo() {
        ChildrenPageForProgramViewController.childreen.removeAll()
        print("in load")
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child(("Childreen")).observeSingleEvent(of: .value, with: {(snapshot) in
                  print(snapshot)
                  
                   if let dic = snapshot.value as? NSDictionary{
                       for each in dic {
                           print(each.key ?? "No data")
                         let child1 = Child()
                           child1.name = (each.value as! NSDictionary)["Name"]  as! String
                           child1.birthDate = (each.value as! NSDictionary)["Birthdate"] as! String
                           child1.gender = (each.value as! NSDictionary)["Gender"] as! String
                         let ageComponents = child1.birthDate.components(separatedBy: "/")
                        let dateDOB = Calendar.current.date(from: DateComponents(year:
                                                           Int(ageComponents[0]), month: Int(ageComponents[1]), day:
                                                           Int(ageComponents[2])))!
                                                                                        

                        ChildrenPageForProgramViewController.age = self.calcAge(birthday: child1.birthDate)
                                  
                        
                        if ((ChildrenPageForProgramViewController.age <= ProgramPageViewController.maxInt &&
                            ChildrenPageForProgramViewController.age >= ProgramPageViewController.minInt) &&
                            ProgramPageViewController.Gender.caseInsensitiveCompare(child1.gender) == .orderedSame){
                                    ChildrenPageForProgramViewController.numOfChildren += 1
                                    ChildrenPageForProgramViewController.childreen.append(child1)
                            

                        }
                        print("num Of CHildren after updated is ?",  ChildrenPageForProgramViewController.numOfChildren )
                        for n in ChildrenPageForProgramViewController.childreen{
                            print("your child nameeee isssss")
                            print(n.name)
                        }
           
                
                       }
                    self.tableView.reloadData()
                    print("num Of CHildren at the end is ?",  ChildrenPageForProgramViewController.numOfChildren )
                    if (ChildrenPageForProgramViewController.numOfChildren == 0){
                       let alert = UIAlertController(title: "Sorry", message: "your children does not fit this program \n do you want to add a child ?", preferredStyle: UIAlertController.Style.alert)
                       let OK = UIAlertAction(title: "Ok", style: .default) { action in
                           
                       }
                        let addChild = UIAlertAction(title: "add child", style: .default) {action in
                            self.addChild()
                            
                            
                        }
                       alert.addAction(OK)
                        alert.addAction(addChild)
                       self.present(alert, animated: true , completion: nil)
                            
                        }
                    
                      
                   }} , withCancel: nil)

        }
    func addChild(){
        AddChildInprofile.page = 1
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(identifier: "AddChildren") as UIViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    func displayMyAlert(userMessage:String , title:String){
       let alertController = UIAlertController(
           title: title,
           message: userMessage,
           preferredStyle: UIAlertController.Style.alert
       )

     
       let confirmAction = UIAlertAction(
        title: "OK", style: UIAlertAction.Style.default);

       alertController.addAction(confirmAction)
      

        present(alertController, animated: true, completion: nil)
    }
    func calcAge(birthday: String) -> Int {
        print("the age isDDeeeeeD", birthday)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/mm/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        print("the age isDDeeeeeD", birthdayDate!)

        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        print("the age isDDD", Date())

        print("the age is111", ChildrenPageForProgramViewController.age)

        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    
    @IBAction func RegisterPressed(_ sender: UIButton) {
       print("the value before updated is ", ProgramPageViewController.RealMaxInt)
        if ChildrenPageForProgramViewController.count == 0 {
            self.displayMyAlert(userMessage: "please select a child to register", title: "")
 
        }
        else{
            if (ProgramPageViewController.IDArray.count == 0){
                print("noooo prograammms")
                self.displayMyAlert(userMessage: "please wait for conformation message", title: "Nice Choise")
                self.prog.savePrgramInFireBase(flag: 2, show: "")
            }
            else{
                    
                for n in ProgramPageViewController.IDArray {
                    if n == ProgramPageViewController.id {
                        self.displayMyAlert(userMessage: "you already register in this program", title: "")
                        return
                    }
                }

            self.displayMyAlert(userMessage: "please wait for conformation message", title: "Nice Choise")
            self.prog.savePrgramInFireBase(flag: 2, show: "")
                
            }
            
        }
        

        
    
    }


}
extension ChildrenPageForProgramViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChildrenPageForProgramViewController.childreen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath) as! ChildrenRegTableViewCell
        cell.name.text = ChildrenPageForProgramViewController.childreen[indexPath.row].name
        cell.age.text = ChildrenPageForProgramViewController.childreen[indexPath.row].birthDate
        cell.gender.text = ChildrenPageForProgramViewController.childreen[indexPath.row].gender
        return cell


    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
         
         if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            print(ChildrenPageForProgramViewController.count , "before everything")
             if cell.accessoryType == .checkmark{
                 cell.accessoryType = .none
                
                ChildrenPageForProgramViewController.count-=1
                ProgramPageViewController.RealMaxInt += ChildrenPageForProgramViewController.count
               let Index = ChildrenPageForProgramViewController.childName.index(of: ChildrenPageForProgramViewController.childreen[indexPath.row].name)
                
                ChildrenPageForProgramViewController.childName.remove(at:Index!)
                                
                print("just a test" ,Index!)

             }
             else{
                 cell.accessoryType = .checkmark
                ChildrenPageForProgramViewController.count+=1
                ProgramPageViewController.RealMaxInt -= ChildrenPageForProgramViewController.count
                for n in ChildrenPageForProgramViewController.childreen{
                    if(n.name ==  ChildrenPageForProgramViewController.childreen[indexPath.row].name){
                        ChildrenPageForProgramViewController.childName.append(ChildrenPageForProgramViewController.childreen[indexPath.row].name)
                    }
                    
                }
                for n in ChildrenPageForProgramViewController.childName {
                    print(n , "the selcted name ")
                }
                
                
              

           }
           
        }
        
     }

    
    
    
}
extension Date {
   var age: Int {
       return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
   }
}

