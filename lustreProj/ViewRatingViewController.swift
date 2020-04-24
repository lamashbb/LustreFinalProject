
import UIKit
import Firebase
import FirebaseAuth
import Foundation
import FirebaseDatabase
class ViewRatingViewController: UIViewController{
    var reviewArr = [review]()

    @IBOutlet weak var ProgImage: UIImageView!
    @IBOutlet weak var ProgName: UILabel!
    @IBOutlet weak var InstName: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var tView: UITableView!
    @IBOutlet weak var price: UILabel!
    
    var imgUrl = ""
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " "
        navigationController?.setNavigationBarHidden(false, animated: true)
        var myBackButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        myBackButton.addTarget(self, action: #selector(backToFirstVC), for: UIControl.Event.touchUpInside)
        myBackButton.setTitle("Back", for: [])
        myBackButton.setTitleColor(UIColor.link, for: [])
        myBackButton.sizeToFit()
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = myCustomBackButtonItem
        writeToArray()
        print("Array dump hereeee")
        loadData()
        
}
 
  
    @objc func backToFirstVC(){
        self.navigationController!.popToRootViewController(animated: true)
        
    }
    func loadData() {        FirbaseRef.Users.child("\(Auth.auth().currentUser!.uid)").child("MyPrograms").observe(.childAdded
                   , with: {(snapshot) in
                      
                      
                          print(snapshot)
                          print("id from history")
                          print(HistoryCurrentProgramViewController.pId)
                           
                           if let dic = snapshot.value as? [String : AnyObject ]{
                               print("dictionary ID")
                               print(dic["id"]!)
                               
                              if (HistoryCurrentProgramViewController.pId == dic["id"] as? String ){
                               
                               print("view rating id=id")
                               self.ProgName.text = dic["ProgramName"] as? String
                               self.InstName.text = dic["InstitutionName"] as? String
                               self.price.text = dic["Price"] as? String
                               self.gender.text = dic["Gender"] as? String
                               self.imgUrl = dic["photo"] as! String
                                self.getImage(url: self.imgUrl){ photo in
                                    if photo != nil {
                                         DispatchQueue.main.async {
                                            self.ProgImage.image = photo
                                        }
                                    }
                                    else{
                                        self.ProgImage.image = UIImage(named: "nophoto")
                                    }
                                }
                              }}
        }
        , withCancel: nil)
        
        
    }
    
    func writeToArray(){

        FirbaseRef.programs.child(HistoryCurrentProgramViewController.pId).child("Ratings").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let dic = snapshot.value as? [String : AnyObject] {
                for each in dic {
                    print(each.key ?? "none")
                let r1 = review()
                r1.rating = (each.value as! NSDictionary)["Rating"] as? String ?? "0.0"
                r1.review = (each.value as! NSDictionary)["Review"] as? String ?? ""
                    r1.name = (each.value as! NSDictionary)["Name"] as? String ?? ""
                self.reviewArr.append(r1)
                self.tView.reloadData()
                print("just appended")
                }
                self.tView.reloadData()
                print("array dump here")
                dump(self.reviewArr)
            }
        
            }

            , withCancel: nil)
 
        
       }
    

    
    }

extension ViewRatingViewController : UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ViewRatingTableViewCell
     //   myCell?.firstName.text = RatingPopUpViewController.reviews[indexPath.row].name
        myCell?.reviewText.text = self.reviewArr[indexPath.row].review
        myCell?.cosmosRating.settings.updateOnTouch = false
        myCell?.cosmosRating.rating = (self.reviewArr[indexPath.row].rating as NSString).doubleValue
        myCell?.firstName.text = self.reviewArr[indexPath.row].name
        
        return myCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
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
