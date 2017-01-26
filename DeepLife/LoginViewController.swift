//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: LoginViewController
// Author Name		: Paul Prashant
// Date             : Oct, 17 2016
// Purpose			: Login file.
//>---------------------------------------------------------------------------------------------------

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, CountriesViewControllerDelegate {

    public class func standardController() -> LoginViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
    }
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtAreaCode: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnAreaCode: UIButton!
    @IBOutlet weak var btnLogin: UIButton!

    var usernameString: NSString? = nil
    var AreaCode: NSString? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtPass.delegate = self
        txtPhone.delegate = self

        btn1.titleLabel?.adjustsFontSizeToFitWidth = true
        btn2.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let fontSize = Constant.deviceWidth/20
        
        btn1.titleLabel!.font = UIFont(name: btn1.titleLabel!.font!.fontName , size: fontSize)
        btn2.titleLabel!.font = UIFont(name: btn2.titleLabel!.font!.fontName , size: fontSize)
        
        txtEmail.font = UIFont(name: txtEmail.font!.fontName , size: fontSize)
        txtPass.font = UIFont(name: txtPass.font!.fontName , size: fontSize)
        txtAreaCode.font = UIFont(name: txtAreaCode.font!.fontName , size: fontSize)
        txtPhone.font = UIFont(name: txtPhone.font!.fontName , size: fontSize)
        btnLogin.titleLabel!.font = UIFont(name: btnLogin.titleLabel!.font!.fontName , size: fontSize)

        clickedEmail(self)
        // Do any additional setup after loading the view.
    }
    @IBAction func clickedPhoneNumber(_ sender: Any) {
        self.txtEmail.isHidden = true
        
        self.btnAreaCode.isHidden = false
        self.txtAreaCode.isHidden = false
        self.txtPhone.isHidden = false
        
        txtPhone.text = nil
        txtPass.text = nil
        
        updateCountry()
    }
    @IBAction func clickedEmail(_ sender: Any) {
        self.txtEmail.isHidden = false
        
        self.btnAreaCode.isHidden = true
        self.txtAreaCode.isHidden = true
        self.txtPhone.isHidden = true
        
        txtEmail.text = nil
        txtPass.text = nil
        txtAreaCode.text = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        if(textField == self.txtPhone){
            let maxLength = 10
            let currentString: NSString = txtPhone.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            
        }
        return true
    }

    
    @IBAction func ClickedLogin(_ sender: Any) {
        view.endEditing(true)
        if ((txtEmail.text?.length)! > 0 && (txtPass.text?.length)! > 0) {
            
            if (txtEmail.text?.isValidEmail())! {
                print("valid email")

                validateLoginDetails()
            }else{
                print("invalid email")
                self.txtEmail.text = nil
                self.txtEmail.becomeFirstResponder()
                
                let alert = UIAlertController(title: "Sorry", message: "Invalid email address.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else if ((txtPhone.text?.length)! > 0 && (txtPass.text?.length)! > 0) {
            
            validateLoginDetails()
        }else{
            print("both the fields are required")
            let alert = UIAlertController(title: "Sorry", message: "Both the fields are required", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validateLoginDetails(){
        self.showMBProgressHUD()
        
        if (txtEmail.text?.length)! > 0  {
            usernameString = txtEmail.text! as NSString
        }else{
            usernameString = txtPhone.text! as NSString
        }
        let str = txtAreaCode.text
        AreaCode = str?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil) as NSString?
        print("AreaCode=",AreaCode as Any)
        print("usernameString=",usernameString as Any)
        
        let url = NSURL(string: Constant.base_url+"/deep_api")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let bodyData = String(format: "User_Name=%@&User_Pass=%@&Service=%@&Param=[]&Country=%@",usernameString!,txtPass.text!,"Log_In",AreaCode!)
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
                      
                        if let list = jsonResult as? NSDictionary
                        {
                            print("list=",list)
                            if let new = list["Response"] as? NSDictionary
                            {
                                print("Profile=",new["Profile"] as Any)
                                
                                UserDefaults.standard.set(self.usernameString!, forKey: "username")
                                UserDefaults.standard.set(self.txtPass.text, forKey: "password")
                                UserDefaults.standard.set(self.AreaCode!, forKey: "country")
                                UserDefaults.standard.synchronize()
                                
                                self.performSegue(withIdentifier: "showHomeView", sender: self)
                                
                            }else if let Request_Error = list["Request_Error"] as? NSDictionary
                            {
                                let alert = UIAlertController(title: "Sorry", message: Request_Error.allValues.first as! String?, preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                            }else{}
                        }
                        
                    } catch let error as NSError {
                        print("error=",error)
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
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Authenticating..."
    }
    
    func hideMBProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak public var backgroundTapGestureRecognizer: UITapGestureRecognizer!
    
    //public var delegate: SignupViewControllerDelegate?
    
    public var phoneNumber: String? {
        if let countryText = txtAreaCode.text, let phoneNumberText = txtPhone.text, !countryText.isEmpty && !phoneNumberText.isEmpty {
            return countryText + phoneNumberText
        }
        return nil
    }
    
    public var country = Country.currentCountry
    
    @IBAction fileprivate func changeCountry(_ sender: UIButton) {
        let countriesViewController = CountriesViewController.standardController()
        countriesViewController.delegate = self
        countriesViewController.cancelBarButtonItemHidden = false
        countriesViewController.selectedCountry = country
        
        let navController = UINavigationController(rootViewController: countriesViewController)
        self.present(navController, animated:true, completion: nil)
    }
    
    public func countriesViewControllerDidCancel(_ countriesViewController: CountriesViewController) {
        self.dismiss(animated: true, completion:nil)
    }
    
    public func countriesViewController(_ countriesViewController: CountriesViewController, didSelectCountry country: Country) {
        self.dismiss(animated: true, completion:nil)
        self.country = country
        updateCountry()
    }
    

    fileprivate func updateCountry() {
        txtAreaCode.text = country.phoneExtension
        updatetxtAreaCode()
    }

    
    fileprivate func updatetxtAreaCode() {
        if txtAreaCode.text == "+" {
            txtAreaCode.text = ""
        }
        else if let countryText = txtAreaCode.text, !countryText.hasPrefix("+") && !countryText.isEmpty {
            txtAreaCode.text = "+" + countryText
        }
    }
    
    @IBAction fileprivate func tappedBackground(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: Validation
    public var countryIsValid: Bool {
        if let countryCodeLength = txtAreaCode.text?.length {
            return country != Country.emptyCountry && countryCodeLength > 1 && countryCodeLength < 5
        }
        return false
    }
    
    public var phoneNumberIsValid: Bool {
        if let phoneNumberLength = txtPhone.text?.length {
            return phoneNumberLength > 5 && phoneNumberLength < 15
        }
        return false
    }

}
private extension String {
    var length: Int {
        return utf16.count
    }
}
