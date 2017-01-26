//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: HomeViewController
// Author Name		: Paul Prashant
// Date             : Oct, 3 2016
// Purpose			: Home View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var lblTotalDisciple: UILabel!
    @IBOutlet weak var lblWin: UILabel!
    @IBOutlet weak var lblBuild: UILabel!
    @IBOutlet weak var lblSend: UILabel!
    
    var username: NSString? = nil
    var password: NSString? = nil
    var country: NSString? = nil
    
    var arrayData : [[String:AnyObject]] = []
    var winCount : Int = 0
    var buildCount : Int = 0
    var sendCount : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Show the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
        winCount = 0
        buildCount = 0
        sendCount = 0
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if UserDefaults.standard.value(forKey: "username") != nil && UserDefaults.standard.value(forKey: "password") != nil {
            //do something here when username & password exists
            username = UserDefaults.standard.value(forKey: "username") as! NSString?
            password = UserDefaults.standard.value(forKey: "password") as! NSString?
            country = UserDefaults.standard.value(forKey: "country") as! NSString?
            
            getDataFromServer()
        } else {
            //no details exists
            self.performSegue(withIdentifier: "gotoLogin", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        addSlideMenuButton()
        
        // Do any additional setup after loading the view.
    }
    

    func getDataFromServer(){
        self.showMBProgressHUD()
        
        let url = NSURL(string: Constant.base_url+"/deep_api")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let bodyData = String(format: "User_Name=%@&User_Pass=%@&Service=%@&Param=[]&Country=%@",username!,password!,"Update",country!)
        print("body=",bodyData)
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            self.hideMBProgressHUD()
            
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                
                if statusCode == 200 {
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options:
                            JSONSerialization.ReadingOptions.mutableContainers)
                        
                        //print(jsonResult)
                        
                        if let list = jsonResult as? NSDictionary
                        {
                            if let Response = list["Response"] as? NSDictionary
                            {
                                if Response["Disciples"] is NSNull {
                                    
                                }else{
                                    self.arrayData = (Response["Disciples"] as? [[String:AnyObject]])!
                                    
                                    for i in 0 ..< self.arrayData.count {
                                        let stage = self.arrayData[i]["stage"]! as! String
                                        
                                        if (stage == "WIN"){
                                            self.winCount = self.winCount+1
                                        }else if (stage == "BUILD"){
                                            self.buildCount = self.buildCount+1
                                        }else if (stage == "SEND"){
                                            self.sendCount = self.sendCount+1
                                        }else{
                                        }
                                    }
                                    DispatchQueue.main.async {
                                        self.lblTotalDisciple.text = String(self.arrayData.count)
                                        self.lblWin.text = String(self.winCount)
                                        self.lblBuild.text = String(self.buildCount)
                                        self.lblSend.text = String(self.sendCount)
                                    }
                                }
                            }
                            else if let Request_Error = list["Request_Error"] as? NSDictionary
                            {
                                
                                if (Request_Error["Authentication"] as! String == "Invalid User"){
                                    self.performSegue(withIdentifier: "gotoLogin", sender: self)
                                }
                                let alert = UIAlertController(title: Request_Error.allValues.first as! String?, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                self.topMostViewController().present(alert, animated: true, completion: nil)
                            }
                        }
                        
                    } catch let error as NSError {
                        let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } catch {
                        let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    let alert = UIAlertController(title: "Sorry", message: "Something went wrong. Please try again later.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func showMBProgressHUD() {
        let hud = MBProgressHUD.showAdded(to: (self.tabBarController?.view)!, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Loading..."
    }
    
    func hideMBProgressHUD() {
        MBProgressHUD.hide(for: (self.tabBarController?.view)!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension UIViewController {
    func topMostViewController() -> UIViewController {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
            // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController()
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {
    override func topMostViewController() -> UIViewController {
        return self.selectedViewController!.topMostViewController()
    }
}

extension UINavigationController {
    override func topMostViewController() -> UIViewController {
        return self.visibleViewController!.topMostViewController()
    }
}
