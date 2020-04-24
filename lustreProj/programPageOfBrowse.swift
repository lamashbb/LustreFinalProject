//
//  File.swift
//  lustreProj
//
//  Created by ghaida habes on 12/03/2020.
//  Copyright © 2020 lam . All rights reserved.
//

//
//  programPageOfBrowse.swift
//  lustreProj
//
//  Created by Shahad X on 16/07/1441 AH.
//  Copyright © 1441 shahad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class programPageOfBrowse: UIViewController {
    
    
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
        // case if childreen
        if BrowsePageViewController.Adult == 0
            {
progName.text =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].name
instName.text =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].instName
price.text = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].price
details.text =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].details
gender.text =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].gender
dates.text =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].Sdate
times.text =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].time
programPageOfBrowse.img =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].phote
programPageOfBrowse.Edate =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].Edate
programPageOfBrowse.id =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].id
               
                   getImage(url: programPageOfBrowse.img) { photo in
                         if photo != nil {
                              DispatchQueue.main.async {
                                 self.progImage.image = photo
                             }
                         }
                         else{
                             self.progImage.image = UIImage(named: "nophoto")
                         }
                         
                     }
programPageOfBrowse.max = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].max
programPageOfBrowse.date = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].Sdate
programPageOfBrowse.minAge = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].minAge
programPageOfBrowse.maxAge = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].maxAge
programPageOfBrowse.ageCat = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].age
programPageOfBrowse.pName =  BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].name
programPageOfBrowse.id = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].id
programPageOfBrowse.Edate = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].Edate
programPageOfBrowse.details = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].details
programPageOfBrowse.Gender = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].gender
programPageOfBrowse.Price = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].price
programPageOfBrowse.insName = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].instName
programPageOfBrowse.times = BrowsePageViewController.SearchProgram[BrowsePageViewController.IndexChild].time
                  
        } // end case child
        
        
        if BrowsePageViewController.Adult == 1
        {progName.text =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].name
    instName.text =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].instName
    price.text = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].price
    details.text =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].details
    gender.text =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].gender
    dates.text =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult ].Sdate
    times.text =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult ].time
    programPageOfBrowse.img =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].phote
    programPageOfBrowse.date =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].Edate
    programPageOfBrowse.id =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].id
                          getImage(url: programPageOfBrowse.img) { photo in
                                if photo != nil {
                                     DispatchQueue.main.async {
                                        self.progImage.image = photo
                                    }
                                }
                                else{
                                    self.progImage.image = UIImage(named: "nophoto")
                                }
                                
programPageOfBrowse.date = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].Sdate       }
programPageOfBrowse.max = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].max
programPageOfBrowse.minAge = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].minAge
programPageOfBrowse.maxAge = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].maxAge
programPageOfBrowse.ageCat = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].age
programPageOfBrowse.pName =  BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].name
programPageOfBrowse.id = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].id
programPageOfBrowse.Edate = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].Edate
programPageOfBrowse.details = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].details
programPageOfBrowse.Gender = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].gender
programPageOfBrowse.Price = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].price
programPageOfBrowse.insName = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].instName
programPageOfBrowse.times = BrowsePageForAdult.SearchProgramForAdult[BrowsePageForAdult.IndexAdult].time
                         
               }
        
///*******************************************************************
        programPageOfBrowse.minInt = Int(programPageOfBrowse.minAge)!
        programPageOfBrowse.maxInt = Int(programPageOfBrowse.maxAge)!
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
            
            if (programPageOfBrowse.ageCat == "Adult"){
                loadUserInfo()
            }
                 
            else if (programPageOfBrowse.ageCat == "child"){
                childReg()
            }

        }
      func loadUserInfo() {
        FirbaseRef.Users.child((Auth.auth().currentUser!.uid)).observeSingleEvent(of: .value, with: {(snapshot) in
        print(snapshot)
        if let dic = snapshot.value as? [String : AnyObject ] {
        for each in dic {
        print("yghfhsaijxjkzchdl")
        programPageOfBrowse.UserDOB = (dic["Birthdate"] as? String )!
        programPageOfBrowse.UserGender = (dic["Gender"]as? String)!
        print(programPageOfBrowse.UserDOB)
        print(programPageOfBrowse.UserGender)
                                                             }
        self.adultReg(DOB: programPageOfBrowse.UserDOB, Gender: programPageOfBrowse.UserGender)
                                                                 }
                   
                                }, withCancel: nil)
            }
                
            
            func adultReg(DOB: String , Gender : String) {

                let id =  programPageOfBrowse.id
                programPageOfBrowse.RealMaxInt = Int( programPageOfBrowse.max)!
        //      ************************************************************************
                print("current user DOB is ", DOB)
                let ageComponents = DOB.components(separatedBy: "/")
                let dateDOB = Calendar.current.date(from: DateComponents(year:
                Int(ageComponents[0]), month: Int(ageComponents[1]), day: Int(ageComponents[2])))!
               programPageOfBrowse.CurrentUserAge = self.calcAge(birthday: DOB)
                print("the age of adult is", programPageOfBrowse.CurrentUserAge)
                
        //      ************************************************************************

                if (( programPageOfBrowse.CurrentUserAge <= programPageOfBrowse.maxInt &&  programPageOfBrowse.CurrentUserAge >= programPageOfBrowse.minInt) &&
                    self.gender.text?.caseInsensitiveCompare(Gender) == .orderedSame) {
                    
                       if ( programPageOfBrowse.RealMaxInt > 0){
                           
                            if (programPageOfBrowse.IDArray.count == 0){
                                    ProgReg()
                            }
                            else{
                                
                                for n in programPageOfBrowse.IDArray {
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
                        programPageOfBrowse.IDArray.append(IDP)
                        print("the num inside dict is", programPageOfBrowse.IDArray.count)

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
            programPageOfBrowse.RealMaxInt = Int(programPageOfBrowse.max)!

            if(programPageOfBrowse.RealMaxInt>0 ){
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
            
            let name1 =  programPageOfBrowse.pName
            let price1 = programPageOfBrowse.Price
            let details1 = programPageOfBrowse.details
            let inst1 = programPageOfBrowse.insName
            let date1 = programPageOfBrowse.date
            let age1 = programPageOfBrowse.ageCat
            let gender1 = programPageOfBrowse.Gender
            let time1 = programPageOfBrowse.times
            let photoURL = programPageOfBrowse.img
            let max1 = programPageOfBrowse.max
            let minAge1 = programPageOfBrowse.minAge
            let maxAge1 = programPageOfBrowse.maxAge
            let id = programPageOfBrowse.id
            let status = "pending"
            let childName = ChildrenPageForProgramViewController.childName
            let Edate1 = programPageOfBrowse.Edate
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
                let name1 =  progName.text

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

                                if n.name == name1 {
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
    



