//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: TestimonialViewController
// Author Name		: Paul Prashant
// Date             : Oct, 18 2016
// Purpose			: Testimonial View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class TestimonialViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var username: NSString? = nil
    var password: NSString? = nil
    var country: NSString? = nil
    
    var tableHeight : CGFloat = 0
    var arrayTestimonial : [[String:AnyObject]] = []
    
    var selectedImage:String?
    var selectedTitle:String?
    var selectedDesc:String?
    var selectedTime:String?
    var selectedUrl:String?
    
    @IBOutlet weak var testimonialTable: UITableView!
    
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
            
            getTestimonialsFromServer()
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
    
    func getTestimonialsFromServer(){
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
                                if Response["NewsFeeds"] is NSNull {
                                    let alert = UIAlertController(title: "Sorry", message: "No data to display", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }else{
                                    self.arrayTestimonial = (Response["NewsFeeds"] as? [[String:AnyObject]])!
                                    DispatchQueue.main.async {
                                        self.testimonialTable.reloadData()
                                        print("reloadData")
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
        
        if (self.arrayTestimonial.count>0) {
            return self.arrayTestimonial.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableHeight/2.52
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.testimonialTable!.dequeueReusableCell(withIdentifier: "idCellTestimonial", for: indexPath)
        // Configure the cell...
        
        let bgView = cell.viewWithTag(111)! as UIView
        let imgView = cell.viewWithTag(112) as! UIImageView
        
        let lblName = cell.viewWithTag(101) as! UILabel
        let lblTime = cell.viewWithTag(102) as! UILabel
        let lblTitle = cell.viewWithTag(103) as! UILabel
        let lblDesc = cell.viewWithTag(104) as! UILabel
        
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
        
        
        if (self.arrayTestimonial.count>0) {
            lblTitle.text = self.arrayTestimonial[indexPath.row]["title"] as! String?
            lblDesc.text = self.arrayTestimonial[indexPath.row]["content"] as! String?
            lblTime.text = self.arrayTestimonial[indexPath.row]["publish_date"] as! String?
            
            let responseUrl = self.arrayTestimonial[indexPath.row]["image_url"] as! String?
            let imgUrl: String? = Constant.base_url + responseUrl!
            imgView.sd_setImage(with: URL(string: imgUrl!)!, placeholderImage: UIImage(named:"video-thumbnail")!.circle)
        }else{
            imgView.image = UIImage(named: "video-thumbnail")!.circle
        }
        
        lblName.font = UIFont(name: lblName.font.fontName , size: tableHeight/29)
        lblTime.font = UIFont(name: lblTime.font.fontName , size: tableHeight/40)
        lblTitle.font = UIFont(name: lblTitle.font.fontName , size: tableHeight/29)
        lblDesc.font = UIFont(name: lblDesc.font.fontName , size: tableHeight/30)
        
        lblName.adjustsFontSizeToFitWidth = true
        lblTime.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

//extension for circular image
extension UIImage {
    var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
