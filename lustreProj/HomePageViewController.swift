//
//  HomePageViewController.swift
//  lustreProj
//
//  Created by Raghad Alfhaid on 25/01/2020.
//  Copyright © 2020 lam . All rights reserved.
//import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase
import CoreLocation
import UserNotifications

class HomePageViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var timer = Timer()
    var seconds = 0
    static var timer1 = ""
    static var art = ""
    static var  educ = ""
    static var  food = ""
    static var   sport  = ""
    static var   lifeStyle = ""
   
    @IBOutlet weak var tableView: UITableView!
    static var progs = [programs] ()
    static var myIndex = 0
    static  var firebaseStorage: Storage?
    var favListArray:NSMutableArray = []
    @IBOutlet weak var LogOutButton: UIButton!
    

    override func viewDidLoad() {
          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector (logIn))
          navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector (LogOut))
           super.viewDidLoad()
        print("The state in th ehoma page", state)
              switch state {
              case .unregistered:
                 print("in unregistereddd ")
                  self.navigationItem.leftBarButtonItem = nil
                  addNavBarImage()
                  loadinfo()
                  HomePageViewController.firebaseStorage = Storage.storage()
                  return
                
              case .loggedIn :
                  print("in Loggeeddd  INNN ")
                  self.navigationItem.rightBarButtonItem = nil
                  loadInterest()
                  timer = Timer.scheduledTimer(timeInterval: 1 , target: self , selector: #selector(counter), userInfo: nil, repeats: true)
                  addNavBarImage()
                  loadinfo()
                  test()
                  HomePageViewController.firebaseStorage = Storage.storage()
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
    
    
    static var LatINT: Double = 0.0
    static var LongINT: Double = 0.0
    
    func test (){
        print("tessttt")
        // Here the bring the new program
         FirbaseRef.programs.observe(.childAdded, with: {(snapshot) in
              print("in program dictionary")
            if  let dict = snapshot.value as? NSDictionary{
                let gender1 = dict["gender"] as! String
                let maxAge = dict["MaxAge"] as! String
                let minAge = dict["MinAge"] as! String
                let maxAgeint = Int(maxAge)
                let minAgeint = Int(minAge)
                let id = dict["id"] as! String
                let category = dict["category"] as! String
                let programName = dict["nameprogam"] as! String
                print(programName)
                if( dict["Status"] as? String == nil){
                         print("inside the if statement")
                         print(dict["Status"] as? String)
                             return }
                FirbaseRef.programs.child("map").observe(.value, with: {(snapshot) in
                            print("in map dictionary")
                        if  let dictinside = snapshot.value as? NSDictionary{
                            let Lat = dictinside["lat"] as! String
                            let Long = dictinside["lng"] as! String
                            HomePageViewController.LatINT = Double(Lat) as! Double
                            HomePageViewController.LongINT = Double(Long) as! Double
                  }}, withCancel: nil)
             let status = dict["Status"] as! String
                            print("Status")
                            print(status)
                    if (status == "New" ){
                        self.MatchUserInterest (id: id, gender: gender1, ageMax: maxAgeint! , ageMin: minAgeint!, category: category, weekDay: 0.0, dayTime: 0.0, logOfProgram: HomePageViewController.LatINT, latOfProgram: HomePageViewController.LongINT, programName: programName) }
                             print("After match user call")
                    
                              
            } }, withCancel: nil)
//        print("start test ")
//        print("raghad alfhaaaiiiiidddddd")
//        MatchUserInterest (id: "-M2XBAfdh_KhmCV1s5Ty", gender: "Male", ageMax: 40 , ageMin: 14, category: "LifeStyle", weekDay: 0.0, dayTime: 0.0, logOfProgram: 45.81353720540261, latOfProgram: 24.392212471125582 , programName: programName )
        print("test is done ")
  } // End of test function
    func loadInterest(){
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child(("Interst")).observe(.value, with: {(snapshot) in
            if let dict = snapshot.value as? [String : AnyObject ]{
                HomePageViewController.art = (dict["Art"]  as?  String)!
                print("art", HomePageViewController.art)
                HomePageViewController.educ = (dict["Education"]  as? String)!
                HomePageViewController.food = (dict["Food&Drinks"]  as? String)!
                HomePageViewController.sport  = (dict["Sport"]  as? String)!
                HomePageViewController.lifeStyle = (dict["LifeStyle"]  as? String)!
                print("3shaaan ghaida " , HomePageViewController.lifeStyle )
            }
        }, withCancel: nil)
 } //End of loadIntesrest()
        
   
    func MatchUserInterest( id :String ,  gender : String , ageMax :Int , ageMin :Int, category : String , weekDay : Double, dayTime : Double,logOfProgram :Double , latOfProgram :Double , programName : String ){
        // call methdo dic
        print("in Matchuser interest")
        var count = 0;
        var Program = [0.0, 0.0, 0.0, 0.0, 0.0, weekDay, dayTime]
        if Auth.auth().currentUser?.uid == nil {
            print("user is niilll")
            return }
         
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").observe(.value , with:{(snapshot) in
                print("in match user interest in database path")
            if  let dict = snapshot.value as? NSDictionary{
                count = count + 1
                print(snapshot)
                print("in dicccccct " , count)
                let UserId = dict["UserId"]  as? String
                let lat = dict["Lati"] as? String
                let log = dict["Long"] as? String
                let UserGender = dict["Gender"] as? String
                if (dict["MaximumDis"] as? String == nil){
                    print("waaas nil the maxi")
                    return }
            let MaxDis = dict["MaximumDis"] as? String
            let birthdate = dict["Birthdate"] as? String
                if (dict["Evenning"] as? String == nil){
                     print("waaas nil the evening")
                                   return }
            let EvenningUser = dict["Evenning"] as? String
            let eveening = Double(EvenningUser!)
            if (dict["WeekDay"] as? String == nil){
                     print("waaas nil the weekday")
                                 return }
            let weekdayUser = dict["WeekDay"] as? String
            let weekday = Double(weekdayUser!)
            let maxD = Double(MaxDis!)
            let lati = Double(lat!)
            let long = Double(log!)
            print("in midlleeee")
            var Clint = [0.0,0.0,0.0,0.0,0.0,weekday,eveening]
                        if ( HomePageViewController.sport == "Sport") {
                                Clint[0] = 1
                         }
                         if ( HomePageViewController.art == "Art ,") {
                              Clint[1] = 1
                         }
                         if ( HomePageViewController.food == "Food&Drinks") {
                              Clint[2] = 1
                        }
                         if ( HomePageViewController.lifeStyle == "lifeStyle ,") {
                              Clint[3] = 1
                        }
                         if ( HomePageViewController.educ == "Education") {
                              Clint[4] = 1
                        }

//0 : SPORT , 1 : ART , 2 :COOKING , 3: LIFESTYLE , 4: EDU , 5: WEEK/WEEKEND (0 for weekDay 1 for weekend) , 6 : DAYTIME/EVENING(// 0 for daytime 1 for evening)
                switch category {
                case "Sport":
                    Program[0] = 1
                   break
                case "Art":
                    Program[1] = 1
                    break
                case "Food&Drinks":
                    Program[2] = 1
                    break
                case "LifeStyle":
                    Program[3] = 1
                    print("category done ")
                    break
                case "Education":
                    Program[4] = 1
                    break
                default:
                   break
                }
        
            
                for n in Program {
                    print("program array " ,n)
                }
                     
                         for n in Clint {
                         print("Client array " ,n )
                                                       }
            let UserAge = self.calcAge(birthday: birthdate!)
            print("user age is " , UserAge)
                var distance = self.CalculateLocation(logOfProgram :logOfProgram, latOfProgram :latOfProgram , LogOfUser : long! , latOfUser :lati! )
                print("user gender is " , UserGender)
                 print("user max distance is " ,distance )
                
                if (UserGender == gender && (UserAge <= ageMax && UserAge >= ageMin ) && maxD! <= distance){
                    
                    var x = self.cosineSim(P: Program, C: Clint as! [Double])
                    print("x isssss " , x)
                    if (x >= 0.5) {
                        print("before notify calling")
                        self.Notify(Id:  id ,programName: programName)
                    }
                  return }// end if
          }// end dict
        }, withCancel: nil)
    } // end of MatchUserInterest function()
    // send message notification
    func Notify(Id :String , programName: String){
          registerCategories()
          print("userrr notify now!!")
          let content = UNMutableNotificationContent()
          content.title = "There is a New Program !"
          content.body = programName
          content.sound = UNNotificationSound.default
          content.categoryIdentifier = "test"
          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
          let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
          UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        // Update the status of the program to OLD
          FirbaseRef.programs.child(Id).observe(.childAdded, with: { (snapshot) in
                if  let dict = snapshot.value as? NSDictionary{
                    let status = ["Status" : "Old"]
                   FirbaseRef.programs.child(Id).updateChildValues(status)
                }}, withCancel: nil)
            } // end of Notify function()
     func registerCategories(){
     let center = UNUserNotificationCenter.current()
     center.delegate = self
     let open = UNNotificationAction(identifier: "open", title: "Show", options: .foreground)
     let category = UNNotificationCategory(identifier: "test", actions: [open], intentIdentifiers: [], options: [])
     center.setNotificationCategories([category])
     } // end of registerCategories()
     // end of registerCategories()
    /** Dot Product **/
     private func dot(A: [Double], B: [Double]) -> Double {
         var x: Double = 0
         for i in 0...A.count-1 {
             x += A[i] * B[i]
         }
         return x
     } // End of dot?
     
     /** Vector Magnitude **/
     private func magnitude(A: [Double]) -> Double {
         var x: Double = 0
         for elt in A {
             x += elt * elt
         }
         return sqrt(x)
     } // end magnitude
     
     /** Cosine similarity **/
     private func cosineSim(P: [Double], C: [Double]) -> Double {
        print("in cosin sim ")
         return dot(A: P, B: C) / (magnitude(A: P) * magnitude(A: C))
        
     } // end of cosineSim
    
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
       } // end of calcAge
    
    
    func CalculateLocation(logOfProgram : Double , latOfProgram :Double , LogOfUser : Double , latOfUser : Double)-> Double{
    print("in calculate location ")
    let coordinate₀ = CLLocation(latitude: latOfProgram, longitude: logOfProgram)
    let coordinate₁ = CLLocation(latitude: latOfUser , longitude: LogOfUser )

        let distanceInMeters = (coordinate₀.distance(from: coordinate₁))/1000
        
    return distanceInMeters
    } // end of CalculateLocation
    
    // timer
    @objc  func counter(){
     var flag = false
     FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").observeSingleEvent(of: .value,  with: {(snapshot) in
          if let dic = snapshot.value as? [String : AnyObject ]{
             print(snapshot)
            if(dic["timer"] as? String == nil){
                
            return
            }
             HomePageViewController.timer1 = (dic["timer"] )! as! String
             print("shahhhaaad")
             flag = true
             }
         
           self.StartTimer(timInt: HomePageViewController.timer1)

         
     }, withCancel: nil)  } // end of counter()
    
    func StartTimer(timInt : String){
        if(timInt == ""){
            return
        }
        var timer1 = Int(timInt)
        print(timInt , "inn timer ")
        timer1! -= 1
        
        var s = String(timer1!)
        let value = ["timer" : s]
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").updateChildValues(value)
         if (timer1 == 0 ){
             print(seconds , " in tiiimmmmerrr ")

            displayMyAlert(userMessage : " I Prefer to Join In  program  ", title: "Done", type1: "WeekDay", type2: "WeekEnd" ,flag: true)

             FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").updateChildValues(value)
            
         }
        
        if (timer1! < 0 ){
          
             timer.invalidate()
            
        }
    } // End of StartTimer()
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if  UserDefaults.standard.object(forKey: "favList") != nil {
            favListArray = NSMutableArray.init(array: UserDefaults.standard.object(forKey: "favList") as! NSMutableArray)
            
        }
    } // End of viewWillAppear()

    
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
    } // End of addNavBarImage()
      
      func loadinfo(){
      //  byChild: "StartDate"
        FirbaseRef.programs.queryOrdered(byChild: "StartDate")
      .observe(.childAdded, with: {(snapshot) in
                    //print(snapshot, "heerrerreee")
                      //print("innnnn")
                       if  let dict = snapshot.value as? NSDictionary{
                         // print(snapshot , "heereee")
                         //print(dict, "dict is printed")
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
                       
                        let prog = programs(name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL,max: max, minAge: minAge , maxAge: maxAge , id :id, Edate: date2)
                        HomePageViewController.progs.insert(prog, at: 0)
                        self.tableView.reloadData()
                        /*
                         for n in HomePageViewController.progs {
                               print(n.name , n.email)
                           }
                          */
                           self.tableView.reloadData()

                       }
                       
                       
               } , withCancel: nil)
         
          }
          
  
      
      @IBAction func handleLogout(_ target: UIBarButtonItem) {
           
                  do {
                      try Auth.auth().signOut()
                      dismiss(animated: true, completion: nil) }
                  catch{
                    //  print("There was a problem signing out")
                  }
              
          
          
      }
    
      
    func displayMyAlert(userMessage:String , title:String , type1 :String ,type2 :String , flag : Bool){
             let alertController = UIAlertController(
                 title: title,
                 message: userMessage,
                 preferredStyle: UIAlertController.Style.alert
             )

           
                   let option1 = UIAlertAction(title: type1, style: .default)
             {
               action in
                
                 
                    if flag == false {
                     return
                    }
                   
                    self.displayMyAlert(userMessage : " I Prefer to Join In  program  ", title: "Done", type1: "Day Time ", type2: "Evening" , flag: false)
                    print("flag is ", flag)

                    
                    UserInfo.WeekDay = "0"
                    UserInfo.dayTime = "0"
                   
                    let value = ["WeekDay" :  UserInfo.WeekDay , "Evenning" : UserInfo.dayTime]
                    FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").updateChildValues(value)
                    
             
                    
              }
              let option2 = UIAlertAction(title: type2, style: .default)
              {
                  action in
                         
                               
                               if flag == false {
                                                   return
                                                  }
                    self.displayMyAlert(userMessage : " I Prefer to Join In  program  ", title: "Done", type1: "Day Time ", type2: "Evening" , flag: false)
                     UserInfo.WeekDay = "1"
                     UserInfo.dayTime = "1"
                  
                               
         
                
                 
             }
             alertController.addAction(option1)
             alertController.addAction(option2)
           FirbaseRef.Users.child((Auth.auth().currentUser!.uid)).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = ["WeekDay" :  UserInfo.WeekDay , "Evenning" : UserInfo.dayTime]
            FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").updateChildValues(value)
            
            
              } , withCancel: nil)
            

         
        
        
        present(alertController, animated: true, completion: nil)
          }
        
     

    

  }


extension HomePageViewController : UITableViewDataSource, UITableViewDelegate {

     
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return HomePageViewController.progs.count
       }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
         
         
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProgramTableViewCell
        print(" in hooome ")
        print(HomePageViewController.progs[indexPath.row].name)
         cell.programName?.text = HomePageViewController.progs[indexPath.row].name
         cell.institutionName?.text = HomePageViewController.progs[indexPath.row].instName
         cell.price?.text = HomePageViewController.progs[indexPath.row].price
         cell.date?.text = HomePageViewController.progs[indexPath.row].Sdate
         cell.age?.text = HomePageViewController.progs[indexPath.row].age
         cell.gender?.text = HomePageViewController.progs[indexPath.row].gender
        

        
        
        
        //image
        cell.programImage.image = nil
        cell.tag += 1
        let img = HomePageViewController.progs[indexPath.row].phote
        getImage(url: img) { photo in
            if photo != nil {
                if cell.tag == cell.tag {
                    DispatchQueue.main.async {
                        cell.programImage.image = photo
                    }
                }
                else{
                       cell.programImage.image = UIImage(named: "nophoto")
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
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         HomePageViewController.myIndex = indexPath.row
         performSegue(withIdentifier: "programSegu", sender: self)

     }
  }


