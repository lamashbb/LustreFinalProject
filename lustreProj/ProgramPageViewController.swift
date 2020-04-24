//
//  ProgramPageViewController.swift
//  lustreProj
//
//  Created by Raghad Alfhaid on 25/01/2020.
//  Copyright © 2020 lam . All rights reserved.
//
//
//  ProgramPageViewController.swift
//  lustreProj
//
//  Created by Raghad Alfhaid on 25/01/2020.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

class ProgramPageViewController: UIViewController  {
    
    @IBOutlet weak var progImage: UIImageView!
    @IBOutlet weak var progName: UILabel!
    @IBOutlet weak var instName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dates: UILabel!
    @IBOutlet weak var times: UILabel!
    static var img = ""
    static var max = ""
    static var age = ""
    static var range = NSMakeRange(0, 10)
    static var minInt = 0
    static var maxInt = 0
    static var ageCat = ""
    static var RealMaxInt = 0
    static var pName = ""
    static var minAge = ""
    static var maxAge = ""
    static var id = ""
    static var Price = ""
    static var details = ""
    static var insName = ""
    static var Gender = ""
    static var date = ""
    static var times = ""
    static var CurrentUserAge = 0
    static var Edate = "" 
    var prof = ProfilePageViewController()
    static var UserDOB = ""
    static var UserGender = ""
    static var IDArray = [String]()



 override func viewDidLoad() {
     super.viewDidLoad()

     // Do any additional setup after loading the view.
      print(TableViewController.favSelected , "in program i can reach this step" )
           print(HomePageViewController.progs[HomePageViewController.myIndex].name)
          print(HomePageViewController.progs[HomePageViewController.myIndex].instName)
          
           if (TableViewController.favSelected == 0){
               print("i'm in home page1")
               progName.text = HomePageViewController.progs[HomePageViewController.myIndex].name
               instName.text = HomePageViewController.progs[HomePageViewController.myIndex].instName
               price.text = HomePageViewController.progs[HomePageViewController.myIndex].price
               details.text = HomePageViewController.progs[HomePageViewController.myIndex].details
               gender.text = HomePageViewController.progs[HomePageViewController.myIndex].gender
               dates.text = HomePageViewController.progs[HomePageViewController.myIndex].Sdate
               times.text = HomePageViewController.progs[HomePageViewController.myIndex].time
               ProgramPageViewController.img = HomePageViewController.progs[HomePageViewController.myIndex].phote
               getImage(url: ProgramPageViewController.img) { photo in
                   if photo != nil {
                        DispatchQueue.main.async {
                           self.progImage.image = photo
                       }
                   }
                   else{
                       self.progImage.image = UIImage(named: "nophoto")
                   }
                   
               }
               ProgramPageViewController.max = HomePageViewController.progs[HomePageViewController.myIndex].max
               ProgramPageViewController.minAge = HomePageViewController.progs[HomePageViewController.myIndex].minAge
            print("the min age iss ??", ProgramPageViewController.minAge)

               ProgramPageViewController.maxAge = HomePageViewController.progs[HomePageViewController.myIndex].maxAge
               ProgramPageViewController.ageCat = HomePageViewController.progs[HomePageViewController.myIndex].age
               ProgramPageViewController.pName =  HomePageViewController.progs[HomePageViewController.myIndex].name
               ProgramPageViewController.id = HomePageViewController.progs[HomePageViewController.myIndex].id
               ProgramPageViewController.Gender = HomePageViewController.progs[HomePageViewController.myIndex].gender
               ProgramPageViewController.insName = HomePageViewController.progs[HomePageViewController.myIndex].instName
               ProgramPageViewController.Price = HomePageViewController.progs[HomePageViewController.myIndex].price
               ProgramPageViewController.details = HomePageViewController.progs[HomePageViewController.myIndex].details
               ProgramPageViewController.date =
              HomePageViewController.progs[HomePageViewController.myIndex].Sdate
              ProgramPageViewController.times = HomePageViewController.progs[HomePageViewController.myIndex].time
              ProgramPageViewController.Edate = HomePageViewController.progs[HomePageViewController.myIndex].Edate
            
            
            
            

           }
           else if (TableViewController.favSelected == 2){
               print("i'm in fav page1")
               progName.text = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].name
               instName.text = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].instName
               price.text = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].price
               details.text = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].details
               gender.text =    FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].gender
               dates.text = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].Sdate
               times.text = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].time
             ProgramPageViewController.img = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].phote
             getImage(url: ProgramPageViewController.img) { photo in
                        if photo != nil {
                            DispatchQueue.main.async {
                                self.progImage.image = photo
                            }
                        }
                        else{
                            self.progImage.image = UIImage(named: "nophoto")
                        }
                             
            }
             ProgramPageViewController.minAge = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].minAge
              ProgramPageViewController.maxAge = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].maxAge
             ProgramPageViewController.max = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].max
             ProgramPageViewController.ageCat = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].age
             ProgramPageViewController.pName =  FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].name
             ProgramPageViewController.id = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].id
             ProgramPageViewController.Gender = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].gender
             ProgramPageViewController.insName = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].instName
                       ProgramPageViewController.Price = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].price
                       ProgramPageViewController.details =
                        FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].details
                       ProgramPageViewController.date =
                           FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].Sdate
                       ProgramPageViewController.times = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].time
            ProgramPageViewController.Edate = FavouritePageViewController.favProgram[FavouritePageViewController.Indexing].Edate

             

           }
            ///*******************************************************************
                      
              if (TableViewController.favSelected == 1 && ViewAll.index == 0){
                                   print("i'm in home page1")
                          progName.text = ViewAll.progs2[ViewAll.indexRow].name
                          instName.text = ViewAll.progs2[ViewAll.indexRow].instName
                          price.text = ViewAll.progs2[ViewAll.indexRow].price
                          details.text = ViewAll.progs2[ViewAll.indexRow].details
                          gender.text = ViewAll.progs2[ViewAll.indexRow].gender
                          dates.text = ViewAll.progs2[ViewAll.indexRow].Sdate
                          times.text = ViewAll.progs2[ViewAll.indexRow].time
                          ProgramPageViewController.img = ViewAll.progs2[ViewAll.indexRow].phote
                          ProgramPageViewController.date = ViewAll.progs2[ViewAll.indexRow].Edate
                          ProgramPageViewController.id = ViewAll.progs2[ViewAll.indexRow].id
                          getImage(url: ProgramPageViewController.img) { photo in
                                       if photo != nil {
                                            DispatchQueue.main.async {
                                               self.progImage.image = photo
                                           }
                                       }
                                       else{
                                           self.progImage.image = UIImage(named: "nophoto")
                                       }
                                       
                                   }
                                 ProgramPageViewController.max = ViewAll.progs2[ViewAll.indexRow].max
                                 ProgramPageViewController.minAge = ViewAll.progs2[ViewAll.indexRow].minAge
                                  ProgramPageViewController.maxAge = ViewAll.progs2[ViewAll.indexRow].maxAge
                                 ProgramPageViewController.ageCat = ViewAll.progs2[ViewAll.indexRow].age
                                 ProgramPageViewController.pName =  ViewAll.progs2[ViewAll.indexRow].name
                                ProgramPageViewController.id = ViewAll.progs2[ViewAll.indexRow].id
                                ProgramPageViewController.Edate = ViewAll.progs2[ViewAll.indexRow].Edate
                                ProgramPageViewController.date = ViewAll.progs2[ViewAll.indexRow].Sdate
                                
                               }
              else if(TableViewController.favSelected == 1 && ViewAll.index == 1){
                  progName.text = ViewAll.SearchNames[ViewAll.indexRow2].name
                  instName.text = ViewAll.SearchNames[ViewAll.indexRow2].instName
                  price.text = ViewAll.SearchNames[ViewAll.indexRow2].price
                  details.text = ViewAll.SearchNames[ViewAll.indexRow2].details
                  gender.text = ViewAll.SearchNames[ViewAll.indexRow2].gender
                  dates.text = ViewAll.SearchNames[ViewAll.indexRow2].Sdate
                  times.text = ViewAll.SearchNames[ViewAll.indexRow2].time
                  ProgramPageViewController.img = ViewAll.SearchNames[ViewAll.indexRow2].phote
                  ProgramPageViewController.date = ViewAll.SearchNames[ViewAll.indexRow2].Edate
                  ProgramPageViewController.id = ViewAll.SearchNames[ViewAll.indexRow2].id
                  getImage(url: ProgramPageViewController.img) { photo in
                               if photo != nil {
                                    DispatchQueue.main.async {
                                       self.progImage.image = photo
                                   }
                               }
                               else{
                                   self.progImage.image = UIImage(named: "nophoto")
                               }
                               
                           }
                         ProgramPageViewController.max = ViewAll.SearchNames[ViewAll.indexRow2].max
                         ProgramPageViewController.minAge = ViewAll.SearchNames[ViewAll.indexRow2].minAge
                          ProgramPageViewController.maxAge = ViewAll.SearchNames[ViewAll.indexRow2].maxAge
                         ProgramPageViewController.ageCat = ViewAll.SearchNames[ViewAll.indexRow2].age
                         ProgramPageViewController.pName =  ViewAll.SearchNames[ViewAll.indexRow2].name
                        ProgramPageViewController.id = ViewAll.SearchNames[ViewAll.indexRow2].id
                        ProgramPageViewController.Edate = ViewAll.SearchNames[ViewAll.indexRow2].Edate
                        ProgramPageViewController.date = ViewAll.SearchNames[ViewAll.indexRow2].Sdate

                
                  
                 
              }
                      
                      
                      
                      ///*******************************************************************
           ProgramPageViewController.minInt = Int(ProgramPageViewController.minAge)!
           ProgramPageViewController.maxInt = Int(ProgramPageViewController.maxAge)!
           loadIDs()


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


     @IBAction func programRegisteration(_ sender: UIButton) {
        switch state {
            case .unregistered:
                sender.isEnabled = false
                displayMyAlertWithLogIn(userMessage: "please sign in to register in programs")
                      return

                case .loggedIn :
                sender.isEnabled = true

        }
        
        if (ProgramPageViewController.ageCat == "Adult"){
            loadUserInfo()
            
        }
             
        else if (ProgramPageViewController.ageCat == "child"){
            childReg()
        }

    }
    
   func loadUserInfo() {
          FirbaseRef.Users.child((Auth.auth().currentUser!.uid)).observeSingleEvent(of: .value, with: {(snapshot) in
                        print(snapshot)
                        if let dic = snapshot.value as? [String : AnyObject ] {
                          for each in dic {
                         print("yghfhsaijxjkzchdl")
                            ProgramPageViewController.UserDOB = (dic["Birthdate"] as? String )!
                            ProgramPageViewController.UserGender = (dic["Gender"]as? String)!
                           print(ProgramPageViewController.UserDOB)
                             print( ProgramPageViewController.UserGender)
                         }
                          self.adultReg(DOB: ProgramPageViewController.UserDOB, Gender: ProgramPageViewController.UserGender)
                             }
             
                          }, withCancel: nil)
      }
          
      
      func adultReg(DOB: String , Gender : String) {

          let id = ProgramPageViewController.id
          ProgramPageViewController.RealMaxInt = Int(ProgramPageViewController.max)!
  //      ************************************************************************
          print("current user DOB is ", DOB)
          let ageComponents = DOB.components(separatedBy: "/")
          let dateDOB = Calendar.current.date(from: DateComponents(year:
          Int(ageComponents[0]), month: Int(ageComponents[1]), day: Int(ageComponents[2])))!
          ProgramPageViewController.CurrentUserAge = self.calcAge(birthday: DOB)
          print("the age of adult is", ProgramPageViewController.CurrentUserAge)
          
  //      ************************************************************************

          if (( ProgramPageViewController.CurrentUserAge <= ProgramPageViewController.maxInt &&  ProgramPageViewController.CurrentUserAge >= ProgramPageViewController.minInt) &&
              self.gender.text?.caseInsensitiveCompare(Gender) == .orderedSame) {
              
                 if ( ProgramPageViewController.RealMaxInt > 0){
                     
                      if (ProgramPageViewController.IDArray.count == 0){
                              ProgReg()
                      }
                      else{
                          
                          for n in ProgramPageViewController.IDArray {
                              if n == id{
                                  self.displayMyAlert(userMessage: "you already register in this program", title: "")
                                  return
                              }
                          }

                             ProgReg()
                  }
              }
              else{
                  self.displayMyAlert(userMessage: "the program is full you can try other programs ", title: "Sorry")
            }
                                        
          }

          else{
              self.displayMyAlert(userMessage: "This program does not fit your age or gender", title: "Sorry")
          }
      }
      func loadIDs(){
          
          FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").observe(.childAdded, with: {(snapshot) in
              if  let dict = snapshot.value as? NSDictionary{
                  let IDP = dict["id"] as! String
                  ProgramPageViewController.IDArray.append(IDP)
                  print("the num inside dict is", ProgramPageViewController.IDArray.count)

              }
                      
                       
                     }
                     
                  , withCancel: nil)
      }
      
     func ProgReg(){
          let alert = UIAlertController(title: "", message: "Do you want your friends see this program ?", preferredStyle: UIAlertController.Style.alert)

         let Yes = UIAlertAction(title: "Yes", style: .default)
         {
           action in
                  self.displayMyAlert(userMessage: "wait for conformation message", title: "Nice Choise")
                  self.savePrgramInFireBase(flag: 0, show: "Yes" )
          }
          let No = UIAlertAction(title: "No", style: .default)
          {
              action in
             
                  self.displayMyAlert(userMessage: "wait for conformation message", title: "Nice Choise")
                  self.savePrgramInFireBase(flag: 0, show: "No" )
         }
         alert.addAction(Yes)
         alert.addAction(No)
         self.present(alert, animated: true, completion: nil)
      }
    
    func childReg() {
        ProgramPageViewController.RealMaxInt = Int(ProgramPageViewController.max)!

        if(ProgramPageViewController.RealMaxInt>0 ){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(identifier: "ChildrenPage") as UIViewController
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else {

        displayMyAlert(userMessage: "the program is full you can try other programs", title: "Sorry")
                     
        }
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
 
    
    func savePrgramInFireBase( flag :Int , show : String) {
        print("the value of show is ???" , show)
        
        let name1 =  ProgramPageViewController.pName
        let price1 = ProgramPageViewController.Price
        let details1 = ProgramPageViewController.details
        let inst1 = ProgramPageViewController.insName
        let date1 = ProgramPageViewController.date
        let age1 = ProgramPageViewController.ageCat
        let gender1 = ProgramPageViewController.Gender
        let time1 = ProgramPageViewController.times
        let photoURL = ProgramPageViewController.img
        let max1 = ProgramPageViewController.max
        let minAge1 = ProgramPageViewController.minAge
        let maxAge1 = ProgramPageViewController.maxAge
        let id = ProgramPageViewController.id
        let status = "pending"
        let childName = ChildrenPageForProgramViewController.childName
        let Edate1 = ProgramPageViewController.Edate
        
//        adult reg
        if flag == 0{
            let values = [ "ProgramName" : name1 , "Price" : price1 , "InstitutionName" : inst1 , "Sdate" : date1 , "Gender" : gender1 , "Age" : age1 , "photo" : photoURL , "details" : details1 , "time" : time1 , "Maxnumber": max1 , "MinAge": minAge1 , "MaxAge" : maxAge1 , "status" : status , "id" : id , "appearToFriends" : show , "Edate" : Edate1] as [String : Any]

            FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").childByAutoId().setValue(values)
            
        }
//            fav
        else if flag == 1{
            let values = [ "ProgramName" : name1 , "Price" : price1 , "InstitutionName" : inst1 , "Sdate" : date1 , "Gender" : gender1 , "Age" : age1 , "photo" : photoURL , "details" : details1 , "time" : time1 , "Maxnumber": max1 , "MinAge": minAge1 , "MaxAge" : maxAge1 , "id" : id , "Edate" : Edate1]
            FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("Favorite").childByAutoId().setValue(values)
        }
//            child reg
        else if flag == 2{
            
            let values = [ "ProgramName" : name1 , "Price" : price1 , "InstitutionName" : inst1 , "Sdate" : date1 , "Gender" : gender1 , "Age" : age1 , "photo" : photoURL , "details" : details1 , "time" : time1 , "Maxnumber": max1 , "MinAge": minAge1 , "MaxAge" : maxAge1 , "status" : status , "id" : id , "childName" : childName , "Edate" : Edate1] as [String : Any]
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").childByAutoId().setValue(values)

        }

    }

    func displayMyAlertWithLogIn(userMessage:String){
       let alert = UIAlertController(title: "", message: userMessage, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            alert.addAction(UIAlertAction(title: "Sign in", style: .default) { (action) -> Void in
                                let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "GoToSignIn")
                               self.navigationController?.pushViewController(viewControllerYouWantToPresent!, animated: true)
                            })
      present(alert, animated: true, completion: nil)
    }

 
    @IBAction func favselected(_ sender: UIButton) {
        let name1 =  ProgramPageViewController.id

            switch state {
                case .unregistered:
                    print(" Nooooo user in Program")
                    sender.isEnabled = false
                    displayMyAlertWithLogIn(userMessage: "please sign in to favorite programs")

                        return
                   
                case .loggedIn :
                    print(" there is a ussserrr in Program ")
                    sender.isEnabled = true
            }
                   
            if sender.isSelected {
                sender.isSelected = false
                print("disselect")
            }
            else {
                    
                sender.isSelected = true
                print("select")
                
                print("before set", FavouritePageViewController.favProgram.count)
                if (FavouritePageViewController.favProgram.count == 0){
                    print("should be zero", FavouritePageViewController.favProgram.count)
                    savePrgramInFireBase(flag: 1, show: "")
                           print("program added first :)")
                }
                else{
                    for n in FavouritePageViewController.favProgram {

                        if n.id == name1 {
                                print("the name is", n.name)
                                print("program already in DB")
                                displayMyAlert(userMessage: "the program already in favorite list", title: "")

                                    return
                            }
                      }
                    savePrgramInFireBase(flag: 1, show: "")
                        print("program added  :)")

                }

        }

  }
    
}
