import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase

class HistoryCurrentProgramViewController: UIViewController {
   
    
    static var pId = ""
    static var IndexHistory = 0
    static var IndexCurrent = 0
    static var index = 0
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var seg: UISegmentedControl!
    
    
    @IBAction func ValueChange(_ sender: Any) {
        if seg.selectedSegmentIndex == 0 {
            HistoryCurrentProgramViewController.index = 0
               }
              if seg.selectedSegmentIndex == 1 {
                HistoryCurrentProgramViewController.index = 1
               }
               tableView.reloadData()
    }
    
    static var CurrentPrograms = [CurrentProgram] ()
    static var HistoryPrograms = [CurrentProgram] ()
    
    override func viewDidLoad() {
       

     

        super.viewDidLoad()
        addNavBarImage()
        switch state {
             case .unregistered:
                HistoryCurrentProgramViewController.HistoryPrograms.removeAll()
                HistoryCurrentProgramViewController.CurrentPrograms.removeAll()
                 displayMyAlert(userMessage: "please sign in to register in programs")
            
             case .loggedIn :
            loadCurrentPrograms()
            loadHistoryPrograms( )
            
        }
        
        // Do any additional setup after loading the view.
    }
    func loadHistoryPrograms(){
       let date = Date()
       let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let CurrentD = format.string(from: date)


        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").observe(.childAdded, with: {(snapshot) in
               print("in history ")
               print(snapshot)
               
               if  let dict = snapshot.value as? NSDictionary{
                                     // print(snapshot , "heereee")
                                      //print(dict, "dict is printed")
                                        let name1 = dict["ProgramName"] as! String
                                        let price1 = dict["Price"] as! String
                                        let details1 = dict["details"] as! String
                                        let inst1 = dict["InstitutionName"] as! String //***
                                        let date1 = dict["Sdate"] as! String
                                        let age1 = dict["Age"] as! String
                                        let gender1 = dict["Gender"] as! String
                                        let time1 = dict["time"] as! String
                                        // image
                                       let photoURL = dict["photo"] as! String
                                       let dateE = dict["Edate"] as! String
                                       let ID = dict["id"] as! String

                  print("in history 2 ")
                  print(dateE)
                print(CurrentD)
               
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
               let ProgramDate = formatter.date(from: dateE)
               
                let formatter2 = DateFormatter()
                 formatter2.dateFormat = "yyyy-MM-dd"
                let CurrentDate = formatter2.date(from: CurrentD)
                
                if  CurrentDate!.compare(ProgramDate!) == ComparisonResult.orderedDescending{
                     print("orderedDescending: ")
                      print("in history 3")
                    let prog = CurrentProgram(name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL, id: ID  )
                    HistoryCurrentProgramViewController.HistoryPrograms.append(prog)

                }

          }
               self.tableView.reloadData()
               
           }
           
        , withCancel: nil)
        
    }
    
    
    
    
    
    
    
    func loadCurrentPrograms(){
        let date = Date()
        let format = DateFormatter()
         format.dateFormat = "yyyy-MM-dd"
         let CurrentD = format.string(from: date)

        
        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").observe(.childAdded, with: {(snapshot) in
            print("my programs are ")
            print(snapshot)
            
            if  let dict = snapshot.value as? NSDictionary{
                                  // print(snapshot , "heereee")
                                   //print(dict, "dict is printed")
                                     let name1 = dict["ProgramName"] as! String
                                     let price1 = dict["Price"] as! String
                                     let details1 = dict["details"] as! String
                                     let inst1 = dict["InstitutionName"] as! String //***
                                     let date1 = dict["Sdate"] as! String
                                     let age1 = dict["Age"] as! String
                                     let gender1 = dict["Gender"] as! String
                                     let time1 = dict["time"] as! String
                                     // image
                                    let photoURL = dict["photo"] as! String
                                     let dateE = dict["Edate"] as! String
                                    let ID = dict["id"] as! String

                let formatter = DateFormatter()
                 formatter.dateFormat = "yyyy-MM-dd"
                let ProgramDate = formatter.date(from: dateE)
                
                
                 let formatter2 = DateFormatter()
                  formatter2.dateFormat = "yyyy-MM-dd"
                 let CurrentDate = formatter2.date(from: CurrentD)
                 
                 if  CurrentDate!.compare(ProgramDate!) == ComparisonResult.orderedDescending{
                    print("history")
                 } else {
                    let prog = CurrentProgram(name: name1, price:price1 , details: details1 , instName: inst1 , date: date1 , age: age1 , gender: gender1 , time: time1 , photo: photoURL, id: ID )
                    HistoryCurrentProgramViewController.CurrentPrograms.append(prog) }
                
            }
          
            self.tableView.reloadData()
            
        }
        
     , withCancel: nil)
        
        
        
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
    
    func displayMyAlert(userMessage:String){
             let alert = UIAlertController(title: "", message: "please sign in to register in programs", preferredStyle: UIAlertController.Style.alert)
                                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                  alert.addAction(UIAlertAction(title: "Sign in", style: .default) { (action) -> Void in
                                      let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "GoToSignIn")
                                     self.navigationController?.pushViewController(viewControllerYouWantToPresent!, animated: true)
                                  })
            present(alert, animated: true, completion: nil)
          }

   

}
extension HistoryCurrentProgramViewController : UITableViewDataSource, UITableViewDelegate {


   
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if HistoryCurrentProgramViewController.index == 0 {
        return HistoryCurrentProgramViewController.CurrentPrograms.count
        }
        else {
            return HistoryCurrentProgramViewController.HistoryPrograms.count
            
        }
     }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

    let cell2 = tableView.dequeueReusableCell(withIdentifier: "cellCurrent" , for: indexPath) as! ViewCell
           print(" innnnn current  ")
    
    
    cell2.rateButton.isHidden=false
    
     if HistoryCurrentProgramViewController.index == 0 {
        
    cell2.rateButton.isHidden=true
    cell2.programName?.text = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].name
    cell2.InstName.text = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].instName
    cell2.gender?.text = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].gender
    cell2.priice?.text = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].price
    cell2.date?.text = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].date
    cell2.age?.text = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].age
      
      //image
      cell2.imageView2.image = nil
      cell2.tag += 1
    let img = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].phote
      getImage(url: img) { photo in
          if photo != nil {
              if cell2.tag == cell2.tag {
                  DispatchQueue.main.async {
                      cell2.imageView2.image = photo
                      
                  }
              }
              else{
                

                     cell2.imageView2.image = UIImage(named: "nophoto")
              }
          }
      }
  
        return cell2 }
     else {
          cell2.programName?.text = HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].name
          cell2.InstName.text = HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].instName
          cell2.gender?.text = HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].gender
          cell2.priice?.text = HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].price
          cell2.date?.text = HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].date
          cell2.age?.text = HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].age
            
            //image
            cell2.imageView2.image = nil
            cell2.tag += 1
          let img = HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].phote
            getImage(url: img) { photo in
                if photo != nil {
                    if cell2.tag == cell2.tag {
                        DispatchQueue.main.async {
                            cell2.imageView2.image = photo
                            
                        }
                    }
                    else{
                           cell2.imageView2.image = UIImage(named: "nophoto")
                    }
                }
            }
        
        cell2.cellBodyFunction = { sender in
            FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").observe(.childAdded, with: {(snapshot) in
                print(snapshot)
               // (each.value as! NSDictionary)
                 if let dic = snapshot.value as? NSDictionary{
                    let name1 = dic["ProgramName"]  as! String
                    print(name1 , "In rate button print the dictionary name")
                    print(cell2.programName?.text , "print the cell name ")
                    print(HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].name , "print the array history name")
                    if name1 == cell2.programName?.text{
                        HistoryCurrentProgramViewController.pId = dic["id"] as! String
                        print(HistoryCurrentProgramViewController.pId , "print the id of the program")
                    }
                    }
               
                
            })
        }
        cell2.rateButtonFunction = { sender in
             //  FirbaseRef.programs.observe(.childAdded, with: {(snapshot) in
                FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").observe(.childAdded, with: {(snapshot) in
                print(snapshot)
               // (each.value as! NSDictionary)
                 if let dic = snapshot.value as? NSDictionary{
                    let name1 = dic["ProgramName"]  as! String
                    print(name1 , "In rate button print the dictionary name")
                    print(cell2.programName?.text , "print the cell name ")
                    print(HistoryCurrentProgramViewController.HistoryPrograms[indexPath.row].name , "print the array history name")
                    if name1 == cell2.programName?.text{
                        HistoryCurrentProgramViewController.pId = dic["id"] as! String
                        print(HistoryCurrentProgramViewController.pId , "print the id of the program")
                    }
                    }
               
                
            })
            }
              return cell2
        
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if HistoryCurrentProgramViewController.index == 0 {
        HistoryCurrentProgramViewController.IndexCurrent = indexPath.row
           // performSegue(withIdentifier: "programSegu", sender: self)
    
    }
           else {
               HistoryCurrentProgramViewController.IndexHistory = indexPath.row
             //  performSegue(withIdentifier: "programSegu", sender: self)
           }
 
    

      }
  
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let programDeleted = HistoryCurrentProgramViewController.CurrentPrograms[indexPath.row].id
     
               print(indexPath.row , "### in current delet  ###")
               if (editingStyle == .delete){
                  print("inside if")
                   FirbaseRef.Users.child(Auth.auth().currentUser!.uid).child(("MyPrograms")).observe(.childAdded){ (snapshot) in
                
                       if let dic = snapshot.value as? NSDictionary{
                           let id = dic["id"] as! String
                        
                           for n in dic {
                            if (id == programDeleted){
                            snapshot.ref.removeValue()
                            return } //if
                        } // for
                       } // dictionary
                      }// snapshot
                    HistoryCurrentProgramViewController.CurrentPrograms.remove(at: indexPath.row)
                   self.tableView.reloadData()
     
               }
           }
     
     
 
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: self)
    }
}
