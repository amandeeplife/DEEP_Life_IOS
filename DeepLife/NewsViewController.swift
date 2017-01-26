//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: NewsViewController
// Author Name		: Paul Prashant
// Date             : Oct, 18 2016
// Purpose			: News View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class NewsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var username: NSString? = nil
    var password: NSString? = nil
    var country: NSString? = nil
    
    var tableHeight : CGFloat = 0
    var arrayNews : [[String:AnyObject]] = []
    
    var selectedImage:String?
    var selectedTitle:String?
    var selectedDesc:String?
    var selectedTime:String?
    var selectedUrl:String?
    
    @IBOutlet weak var NewsTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Show the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
        if UserDefaults.standard.value(forKey: "username") != nil && UserDefaults.standard.value(forKey: "password") != nil {
            //do something here when username & password exists
            username = UserDefaults.standard.value(forKey: "username") as! NSString?
            password = UserDefaults.standard.value(forKey: "password") as! NSString?
            country = UserDefaults.standard.value(forKey: "country") as! NSString?
            
            getNewsDataFromServer()
        } else {
            //no details exists
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topBar =  self.navigationController?.navigationBar.frame.height
        let bottomBar = self.tabBarController?.tabBar.frame.height
        tableHeight = Constant.deviceHeight-(Constant.statusBar+topBar!+bottomBar!)
        
        addSlideMenuButton()

    }
    func getNewsDataFromServer(){
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
                                if Response["NewsFeeds"] is NSNull {
                                    let alert = UIAlertController(title: "Sorry", message: "No data to display", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }else{
                                    self.arrayNews = (Response["NewsFeeds"] as? [[String:AnyObject]])!
                                    DispatchQueue.main.async {
                                        self.NewsTable.reloadData()
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
        
        if (self.arrayNews.count>0) {
            return self.arrayNews.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableHeight/3.52
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.NewsTable!.dequeueReusableCell(withIdentifier: "idCellNews", for: indexPath)
        // Configure the cell...
        
        let bgView = cell.viewWithTag(211)! as UIView
        let imgView = cell.viewWithTag(212) as! UIImageView
        
        let lblTime = cell.viewWithTag(202) as! UILabel
        let lblTitle = cell.viewWithTag(203) as! UILabel
        let lblDesc = cell.viewWithTag(204) as! UILabel
        
        bgView.backgroundColor = UIColor.white
        // corner radius
        bgView.layer.cornerRadius = 5
        // border
        bgView.layer.borderWidth = 0.0
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        // shadow
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        bgView.layer.shadowOpacity = 0.7
        bgView.layer.shadowRadius = 4.0
        
        if (self.arrayNews.count>0) {
            lblTitle.text = self.arrayNews[indexPath.row]["title"] as! String?
            lblDesc.text = self.arrayNews[indexPath.row]["content"] as! String?
            lblTime.text = self.arrayNews[indexPath.row]["publish_date"] as! String?
            
            let responseUrl = self.arrayNews[indexPath.row]["image_url"] as! String?
            let imgUrl: String? = Constant.base_url + responseUrl!
            imgView.sd_setImage(with: URL(string: imgUrl!)!, placeholderImage: UIImage(named:"video-thumbnail")!.circle)
        }else{
            imgView.image = UIImage(named: "video-thumbnail")!.circle
        }
        
        lblTitle.font = UIFont(name: lblTitle.font.fontName , size: self.NewsTable.rowHeight/7)
        lblDesc.font = UIFont(name: lblDesc.font.fontName , size: self.NewsTable.rowHeight/8)
        lblTime.font = UIFont(name: lblTime.font.fontName , size: self.NewsTable.rowHeight/10)
        
        lblTime.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row)selected")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedTitle = self.arrayNews[indexPath.row]["title"] as! String?
        selectedDesc = self.arrayNews[indexPath.row]["content"] as! String?
        selectedTime = self.arrayNews[indexPath.row]["publish_date"] as! String?
        let responseUrl = self.arrayNews[indexPath.row]["image_url"] as! String?
        selectedUrl = Constant.base_url + responseUrl!
        
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailView") {
            let vc = segue.destination as! NewsDetailViewController
            vc.imgText = selectedImage
            vc.titleText = selectedTitle
            vc.detailText = selectedDesc
            vc.timeText = selectedTime
            vc.imgText = selectedUrl
        }      
    }
}
@IBDesignable class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
                                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                    attributes: [NSFontAttributeName: font],
                                                                    context: nil).size
            super.drawText(in: CGRect(x:0,y: 0,width: self.frame.width, height:ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}
