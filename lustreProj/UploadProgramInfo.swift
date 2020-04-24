//
//  UploadProgramInfo.swift
//  lustreProj
//
//  Created by Shahad X on 06/08/1441 AH.
//  Copyright © 1441 lam . All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UploadProgramInfo: UIViewController {

    
    @IBOutlet weak var Img: UIImageView!
    
    
    @IBOutlet weak var programName: UILabel!
    
    @IBOutlet weak var InstName: UILabel!
    
    @IBOutlet weak var details: UITextView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    
    @IBOutlet weak var date: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
         
    static var pName1 = ""
    static var Sdate1 = ""
    static var Edate1 = ""
    static var price1 = ""
    static var details1 = ""
    static var InName1 = ""
    static var age1 = ""
    static var gender1 = ""
    static var imgURL1 = ""
    static var max1 = ""
    static var minage1 = ""
    static var maxAge1 = ""
    static var PID1 = ""
    static var status1 = ""
    static var appearToFriend1 = ""
    static var UserDOB = ""
    static var UserGender = ""
    static var RealMaxInt = 0
    static var CurrentUserAge = 0
    static var maxInt = 0
    static var minInt = 0
    static var IDArray = [String]()
    static var Ptime = ""
    static var ageCat = ""

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    
    
    func  loadProgramInfo(programN :String , InstN :String , Price:String ,detail:String , genderP :String, Sdate :String , timeP :String ,img :String , Edate :String , Pid:String , max:String , minAge:String,maxAge:String , ageCategory:String){
        programName.text = programN
        InstName.text =  InstN
        price.text = Price
        details.text = detail
        gender.text = genderP
        date.text = Sdate
        time.text =  timeP
        UploadProgramInfo.pName1 = programN
        UploadProgramInfo.InName1 = InstN
        UploadProgramInfo.price1 = Price
        UploadProgramInfo.details1 = detail
        UploadProgramInfo.gender1 = genderP
        UploadProgramInfo.Sdate1 = Sdate
        UploadProgramInfo.Ptime = timeP
        UploadProgramInfo.imgURL1 =  img
        UploadProgramInfo.Edate1 = Edate
        UploadProgramInfo.PID1 = Pid
        UploadProgramInfo.max1 = max
        UploadProgramInfo.minage1 = minAge
        UploadProgramInfo.maxAge1 = maxAge
        UploadProgramInfo.maxInt = Int(maxAge)!
        UploadProgramInfo.minInt = Int(minAge)!
        UploadProgramInfo.ageCat = ageCategory
        
        
                       
        getImage(url:UploadProgramInfo.imgURL1) { photo in
                                 if photo != nil {
                                      DispatchQueue.main.async {
                                         self.Img.image = photo
                                     }
                                 }
                                 else{
                                     self.Img.image = UIImage(named: "nophoto")
                                 }
                                 
                             }
        
        
        
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
            if (UploadProgramInfo.ageCat == "Adult"){
                loadUserInfo()
                
            }
                 
            else if (UploadProgramInfo.ageCat == "child"){
                childReg()
            }
             
            

         }
    
       func loadUserInfo() {
         FirbaseRef.Users.child((Auth.auth().currentUser!.uid)).observeSingleEvent(of: .value, with: {(snapshot) in
         print(snapshot)
         if let dic = snapshot.value as? [String : AnyObject ] {
         for each in dic {
         UploadProgramInfo.UserDOB = (dic["Birthdate"] as? String )!
         UploadProgramInfo.UserGender = (dic["Gender"]as? String)!
        
                                                              }
         self.adultReg(DOB: UploadProgramInfo.UserDOB, Gender: UploadProgramInfo.UserGender)
                                                                  }
                    
                                 }, withCancel: nil)
             }
                 
             
             func adultReg(DOB: String , Gender : String) {
                // from where the id??

                 let id =  UploadProgramInfo.PID1
                 UploadProgramInfo.RealMaxInt = Int( UploadProgramInfo.max1)!
         //      ************************************************************************
                 print("current user DOB is ", DOB)
                 let ageComponents = DOB.components(separatedBy: "/")
                 let dateDOB = Calendar.current.date(from: DateComponents(year:
                 Int(ageComponents[0]), month: Int(ageComponents[1]), day: Int(ageComponents[2])))!
                UploadProgramInfo.CurrentUserAge = self.calcAge(birthday: DOB)
                 print("the age of adult is", UploadProgramInfo.CurrentUserAge)
                 
         //      ************************************************************************

                 if (( UploadProgramInfo.CurrentUserAge <= UploadProgramInfo.maxInt &&  UploadProgramInfo.CurrentUserAge >= UploadProgramInfo.minInt) &&
                     self.gender.text?.caseInsensitiveCompare(Gender) == .orderedSame) {
                     
                        if ( UploadProgramInfo.RealMaxInt > 0){
                            
                             if (UploadProgramInfo.IDArray.count == 0){
                                     ProgReg()
                             }
                             else{
                                 
                                 for n in UploadProgramInfo.IDArray {
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
                        UploadProgramInfo.IDArray.append(IDP)
                         print("the num inside dict is", UploadProgramInfo.IDArray.count)

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
            UploadProgramInfo.RealMaxInt = Int(UploadProgramInfo.max1)!

             if(UploadProgramInfo.RealMaxInt>0 ){
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
             
            let name1 = UploadProgramInfo.pName1
            let price1 = UploadProgramInfo.price1
            let details1 = UploadProgramInfo.details1
            let inst1 = UploadProgramInfo.InName1
            let date1 = UploadProgramInfo.Sdate1
            let age1 = UploadProgramInfo.age1
            let gender1 = UploadProgramInfo.gender1
            let time1 = UploadProgramInfo.Ptime
            let photoURL = UploadProgramInfo.imgURL1
             let max1 = UploadProgramInfo.max1
            let minAge1 = UploadProgramInfo.minage1
             let maxAge1 = UploadProgramInfo.maxAge1
            let id = UploadProgramInfo.PID1
             let status = "pending"
             let childName = ChildrenPageForProgramViewController.childName
            let Edate1 = UploadProgramInfo.Edate1
   //        adult reg
             if flag == 0{
                 let values = [ "ProgramName" : name1 , "Price" : price1 , "InstitutionName" : inst1 , "Sdate" : date1 , "Gender" : gender1 , "Age" : age1 , "photo" : photoURL , "details" : details1 , "time" : time1 , "Maxnumber": max1 , "MinAge": minAge1 , "MaxAge" : maxAge1 , "status" : status , "id" : id , "appearToFriends" : show , "Edate" : Edate1] as [String : Any]

                 FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").childByAutoId().setValue(values)
                 
             }
     //            fav
             else if flag == 1{
                let values = [ "ProgramName" : name1 , "Price" : price1 , "InstitutionName" : inst1 , "Sdate" : date1 , "Gender" : gender1 , "Age" : age1 , "photo" : photoURL , "details" : details1 , "time" : time1 , "Maxnumber": max1 , "MinAge": minAge1 , "MaxAge" : maxAge1 , "id" : id , "Edate" : Edate1] as [String : Any]
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
                 let name1 =  programName.text

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
     


