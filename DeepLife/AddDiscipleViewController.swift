//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: AddDiscipleViewController
// Author Name		: Paul Prashant
// Date             : Oct, 25 2016
// Purpose			: Add Disciple View.
//>---------------------------------------------------------------------------------------------------

import UIKit
import CoreData

class AddDiscipleViewController: UIViewController {

    var username: NSString? = nil
    var password: NSString? = nil
    var country: NSString? = nil
    
    var people = [NSManagedObject]()
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtNotes: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.value(forKey: "username") != nil && UserDefaults.standard.value(forKey: "password") != nil {
            //do something here when username & password exists
            username = UserDefaults.standard.value(forKey: "username") as! NSString?
            password = UserDefaults.standard.value(forKey: "password") as! NSString?
            country = UserDefaults.standard.value(forKey: "country") as! NSString?
        } else {
            //no details exists
        }
        
        //fetch data from coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Disciple")
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            people = results as! [NSManagedObject]
            //print(people[0].value(forKey: "name") as Any)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(AddDiscipleViewController.btnDismissVC))
        self.navigationItem.leftBarButtonItem = cancel
        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(AddDiscipleViewController.btnCreateDisciple))
        self.navigationItem.rightBarButtonItem = save

        
        let image : UIImage = UIImage(named: "placeholder")!
        profilePic.image = image.circle
        
        // Do any additional setup after loading the view.
    }
    
    func btnDismissVC() {
        
        _ = navigationController?.popViewController(animated: true)
    }

    func btnCreateDisciple() {
        // prepare json data
        let myArrayOfDict :[[String:AnyObject]] = [["Country":"91" as AnyObject,
                                                    "Created":"Today" as AnyObject,
                                                    "DisplayName":"Paul" as AnyObject,
                                                    "Email":"abc@gmail.com" as AnyObject,
                                                    "FullName":"Paul Prashant" as AnyObject,
                                                    "Gender":"Male" as AnyObject,
                                                    "ID":"1" as AnyObject,
                                                    "ImagePath":"0" as AnyObject,
                                                    "ImageURL":"0" as AnyObject,
                                                    "MentorID":"0" as AnyObject,
                                                    "Phone":"98667456789" as AnyObject,
                                                    "Role":"0" as AnyObject,
                                                    "SerID":"0" as AnyObject,
                                                    "Stage":"WIN" as AnyObject]]
        
        print(myArrayOfDict.toJSONString())
        
        let json = ["User_Name":username!, "User_Pass":password!,"Service":"AddNew_Disciples","Country":country!, "Param": myArrayOfDict.toJSONString()] as [String : Any]
        print(json)
        // create post request
        let url = NSURL(string: Constant.base_url+"/deep_api")!
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            do {
                guard let data = data else { return }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
            } catch {
                let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        task.resume()
        addName()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Implement the addName IBAction
    func addName() {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.saveName(textField!.text!)
                                        print(textField!.text!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func saveName(_ name: String) {
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "Disciple",
                                                 in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}
