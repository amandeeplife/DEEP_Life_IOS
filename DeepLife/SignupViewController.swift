//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: SignupViewController
// Author Name		: Paul Prashant
// Date             : Oct, 13 2016
// Purpose			: Singup file.
//>---------------------------------------------------------------------------------------------------


import UIKit

class SignupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CountriesViewControllerDelegate {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public class func standardController() -> SignupViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as! SignupViewController
    }
    
    @IBOutlet var getGender: UIPickerView! = UIPickerView()
    
    let gender = ["Male", "Female", "Other"]

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak public var txtAreaCode: UITextField!
    @IBOutlet weak public var txtPhone: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtconfPass: UITextField!
    
    @IBOutlet weak public var countryButton: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnAlready: UIButton!
    
    var AreaCode: NSString? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.delegate = self
        txtEmail.delegate = self
        txtGender.delegate = self
        txtCountry.delegate = self
        txtAreaCode.delegate = self
        txtPhone.delegate = self
        txtPass.delegate = self
        txtconfPass.delegate = self
        
        txtAreaCode.adjustsFontSizeToFitWidth = true
        btnAlready.titleLabel?.adjustsFontSizeToFitWidth = true
        
        getGender.isHidden = true
        self.txtGender.inputAccessoryView = getGender

        let fontSize = Constant.deviceWidth/20
        
        txtName.font = UIFont(name: txtName.font!.fontName , size: fontSize)
        txtEmail.font = UIFont(name: txtEmail.font!.fontName , size: fontSize)
        txtGender.font = UIFont(name: txtGender.font!.fontName , size: fontSize)
        txtCountry.font = UIFont(name: txtCountry.font!.fontName , size: fontSize)
        txtAreaCode.font = UIFont(name: txtAreaCode.font!.fontName , size: fontSize)
        txtPhone.font = UIFont(name: txtPhone.font!.fontName , size: fontSize)
        txtPass.font = UIFont(name: txtPass.font!.fontName , size: fontSize)
        txtconfPass.font = UIFont(name: txtconfPass.font!.fontName , size: fontSize)
        
        btnSignup.titleLabel!.font = UIFont(name: btnSignup.titleLabel!.font!.fontName , size: fontSize)
        countryButton.titleLabel!.font = UIFont(name: countryButton.titleLabel!.font!.fontName , size: fontSize)
        // Do any additional setup after loading the view.
    }
    
    
    // returns the # of rows in each component..
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        txtGender.text = gender[row]
        getGender.isHidden = true
        
        updateCountry()
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1 {
            
            return true
        }else if textField.tag == 2 {
            
            return true
        }else if textField.tag == 3 {
            txtGender.text = gender[0]
            getGender.isHidden = false
            return false
        }else if textField.tag == 4 {
            
            return true
        }else if textField.tag == 5 {
            
            return true
        }else if textField.tag == 6 {
            print("tag6")
            view.endEditing(true)
            KeyboardAvoiding.avoidingView = self.txtPass
            return true
        }else if textField.tag == 7 {
            print("tag7")
            view.endEditing(true)
            KeyboardAvoiding.avoidingView = self.txtconfPass
            return true
        }else{
            return true
        }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        view.endEditing(true)
        return true
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
    
    @IBAction func ClickedSignUp(_ sender: Any) {
        if ((txtName.text?.length)! > 0 && (txtEmail.text?.length)! > 0 && (txtGender.text?.length)! > 0 && (txtCountry.text?.length)! > 0 && (txtAreaCode.text?.length)! > 0 && (txtPhone.text?.length)! > 0 && (txtPass.text?.length)! > 0 && (txtconfPass.text?.length)! > 0) {
            
            if (txtEmail.text?.isValidEmail())! {
                print("valid email")
                if (txtPass.text == txtconfPass.text){
                    registerNewUser()
                }else{
                    print("Passwords do not match, please retype")
                    self.txtPass.text = nil
                    self.txtconfPass.text = nil
                    self.txtPass.becomeFirstResponder()
                    
                    let alert = UIAlertController(title: "Sorry", message: "Passwords do not match, please retype", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }else{
                print("invalid email")
                self.txtEmail.text = nil
                self.txtEmail.becomeFirstResponder()
                
                let alert = UIAlertController(title: "Sorry", message: "Invalid email address.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            print("All fields are required")
            let alert = UIAlertController(title: "Sorry", message: "All fields are required", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    func registerNewUser(){
        self.showMBProgressHUD()
        
        let str = txtAreaCode.text
        AreaCode = str?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil) as NSString?
        print(AreaCode as Any)
        // prepare json data
        let myArrayOfDict :[[String:AnyObject]] = [["User_Country":AreaCode as AnyObject,
                                                    "User_Email":txtEmail.text as AnyObject,
                                                    "User_Gender":txtGender.text as AnyObject,
                                                    "User_Name":txtName.text as AnyObject,
                                                    "User_Pass":txtPass.text as AnyObject,
                                                    "User_Phone":txtPhone.text as AnyObject]]
        
        print(myArrayOfDict.toJSONString())
        
        let json = ["User_Name":txtName.text!, "User_Pass":txtPass.text!,"Service":"Sign_Up","Country":AreaCode!, "Param": myArrayOfDict.toJSONString()] as [String : Any]
        print(json)
        // create post request
        let url = NSURL(string: Constant.base_url+"/deep_api")!
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                self.hideMBProgressHUD()
            }
            if let error = error {
                let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            do {
                guard let data = data else { return }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else { return }
                print("json:", json)
                if let Request_Error = json["Request_Error"] as? NSDictionary
                {
                    let alert = UIAlertController(title: "Sorry", message: Request_Error.allValues.first as! String?, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    UserDefaults.standard.set(self.txtPhone.text, forKey: "username")
                    UserDefaults.standard.set(self.txtPass.text, forKey: "password")
                    UserDefaults.standard.set(self.AreaCode!, forKey: "country")
                    UserDefaults.standard.synchronize()
                    
                    self.performSegue(withIdentifier: "showHome", sender: self)
                }
                
            } catch {
                print("error:", error)
                let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

        }
        
        task.resume()
    }
    
    func showMBProgressHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Registering..."
    }
    
    func hideMBProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak public var backgroundTapGestureRecognizer: UITapGestureRecognizer!
    
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
    
    @IBAction fileprivate func textFieldDidChangeText(_ sender: UITextField) {
        if let countryText = sender.text, sender == txtAreaCode {
            country = Countries.countryFromPhoneExtension(countryText)
        }
        updateTitle()
    }
    
    fileprivate func updateCountry() {
        txtAreaCode.text = country.phoneExtension
        updatetxtAreaCode()
        updateTitle()
    }
    
    fileprivate func updateTitle() {
        updatetxtAreaCode()
        if txtAreaCode.text == "+" {
        } else {
            txtCountry.text = country.name
        }
        
        var title = "Your Phone Number"
        if let newTitle = phoneNumber  {
            title = newTitle
        }
        navigationItem.title = title

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
extension String {
    func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
}
extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}

private extension String {
    var length: Int {
        return utf16.count
    }
}
