//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: DiscipleViewController
// Author Name		: Paul Prashant
// Date             : Oct, 18 2016
// Purpose			: Disciple View.
//>---------------------------------------------------------------------------------------------------

import UIKit


class DiscipleViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentCntrl: UISegmentedControl!
    @IBOutlet weak var discipleTable: UITableView!
    
    var username: NSString? = nil
    var password: NSString? = nil
    var country: NSString? = nil
    
    var arrayDisciple : [[String:AnyObject]] = []
    var tableHeight : CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if UserDefaults.standard.value(forKey: "username") != nil && UserDefaults.standard.value(forKey: "password") != nil {
            //do something here when username & password exists
            username = UserDefaults.standard.value(forKey: "username") as! NSString?
            password = UserDefaults.standard.value(forKey: "password") as! NSString?
            country = UserDefaults.standard.value(forKey: "country") as! NSString?
            
            getDiscipleDataFromServer()
        } else {
            //no details exists
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let topBar =  self.navigationController?.navigationBar.frame.height
        let bottomBar = self.tabBarController?.tabBar.frame.height
        tableHeight = Constant.deviceHeight-(Constant.statusBar+topBar!+bottomBar!)
        
        segmentCntrl.tintColor = UIColor(red: 0/255, green: 168/255, blue: 277/255, alpha: 1.0)
        
        addSlideMenuButton()
    }
    func getDiscipleDataFromServer(){
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
                        
                        print(jsonResult)
                        
                        if let list = jsonResult as? NSDictionary
                        {
                            if let Response = list["Response"] as? NSDictionary
                            {
                                if Response["Disciples"] is NSNull {
                                    let alert = UIAlertController(title: "Sorry", message: "No data to display", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }else{
                                    self.arrayDisciple = (Response["Disciples"] as? [[String:AnyObject]])!
                                    DispatchQueue.main.async {
                                        self.discipleTable.reloadData()
                                    }
                                }
                                
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
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (self.arrayDisciple.count > 0){
            return self.arrayDisciple.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableHeight/6.1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("editingStyle")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Archive") { action, index in
            print("Archive")
            //self.removeObjectAtIndexPath(indexPath, animated: true)
        }
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.discipleTable!.dequeueReusableCell(withIdentifier: "idCellDisciple", for: indexPath)
        
        // Configure the cell...
        let imgView = cell.viewWithTag(399) as? UIImageView
        
        let lblName = cell.viewWithTag(301) as? UILabel
        let lblEmail = cell.viewWithTag(302) as? UILabel
        let btnWin = cell.viewWithTag(303) as? UIButton

        
        if (self.arrayDisciple.count>0) {
            lblName?.text = self.arrayDisciple[indexPath.row]["displayName"] as! String?
            lblEmail?.text = self.arrayDisciple[indexPath.row]["email"] as! String?
            
            let responseUrl = self.arrayDisciple[indexPath.row]["picture"] as! String?
            let imgUrl: String? = Constant.base_url + responseUrl!
            imgView?.sd_setImage(with: URL(string: imgUrl!)!, placeholderImage: UIImage(named:"placeholder")!.circle)
        }else{
            imgView?.image = UIImage(named: "placeholder")!.circle
        }
        
        lblName?.font = UIFont(name: (lblName?.font.fontName)! , size: tableHeight/30)
        lblEmail?.font = UIFont(name: (lblEmail?.font.fontName)! , size: tableHeight/37)
        btnWin?.titleLabel!.font =  UIFont(name: (btnWin?.titleLabel!.font.fontName)!, size: tableHeight/27)
        
        lblName?.adjustsFontSizeToFitWidth = true
        lblEmail?.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = UIColor.clear

        return cell
    }

    
}
