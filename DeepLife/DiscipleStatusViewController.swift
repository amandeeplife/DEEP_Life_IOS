//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: DiscipleStatusViewController
// Author Name		: Paul Prashant
// Date             : Nov, 8 2016
// Purpose			: Disciple Status View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class DiscipleStatusViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var statusTable: UITableView!
    @IBOutlet weak var segmentCntrl: UISegmentedControl!
    
    var arrayQues : [[String:AnyObject]] = []
    var dicQues : NSDictionary = [:]
    var tableHeight : CGFloat = 0
    var rowsCount : Int = 0

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Show the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false

        getQuestionsFromServer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topBar =  self.navigationController?.navigationBar.frame.height
        let bottomBar = self.tabBarController?.tabBar.frame.height
        tableHeight = Constant.deviceHeight-(Constant.statusBar+topBar!+bottomBar!)
        
        segmentCntrl.tintColor = UIColor(red: 0/255, green: 168/255, blue: 277/255, alpha: 1.0)
        
        let organize = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(DiscipleStatusViewController.btnOrganize))
        self.navigationItem.rightBarButtonItem = organize
        
    }
    
    func getQuestionsFromServer(){
        let url = NSURL(string: Constant.base_url+"/deep_api")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let bodyData = String(format: "User_Name=%@&User_Pass=%@&Service=%@&Param=[]&Country=%@","975652225","asdf123","GetAll_Questions","68")
        print("body=",bodyData)
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            //print("response=",response!)
            
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                
                if statusCode == 200 {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options:
                            JSONSerialization.ReadingOptions.mutableContainers)
                        
                        //print(jsonResult)
                        
                        if let list = jsonResult as? NSDictionary
                        {
                            if let Response = list["Response"] as? NSArray
                            {
                                self.arrayQues = (Response[1] as? [[String:AnyObject]])!
                                let myNewName = NSMutableArray(array:self.arrayQues)
                                
                                for i in 0 ..< self.arrayQues.count {
                                    //print("ques=",self.arrayQues[i]["category"]!)
                                    let WIN : Int = 1
                                    let myString = String(WIN)
                                    
                                    if (self.arrayQues[i]["category"]! as! String == myString){
                                        self.rowsCount = self.rowsCount+1
                                        print("rowsCount=",self.rowsCount)
                                    }else{
                                        
                                        myNewName.remove(at: i)
                                        print("i=",i)
                                        print("new=",myNewName)
                                        print(myNewName.count)
                                    }
                                }
                                
                                
                                DispatchQueue.main.async {
                                    self.statusTable.reloadData()
                                    print("reloadData")
                                }
                                
                            }
                        }
                        
                    } catch let error as NSError {
                        print("error=",error)
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    func btnOrganize() {
        print("Organize")
        
    }
    @IBAction func decreaseValue(_ sender: Any) {
        print("decreaseValue")
    }
    @IBAction func increaseValue(_ sender: Any) {
        print("increaseValue")
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
        
        if (self.rowsCount>0) {
            return self.rowsCount
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableHeight/5.6

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.statusTable!.dequeueReusableCell(withIdentifier: "idCellDisciplestatus", for: indexPath)
        
        // Configure the cell...
        
        let onColor  = UIColor.green
        let offColor = UIColor.red
        
        
        let mSwitch = cell.viewWithTag(9999) as? UISwitch
        let mview = cell.viewWithTag(9998) as UIView!
        
        let lblQues = cell.viewWithTag(9997) as? UILabel
        
        mSwitch?.isHidden = false
        mview?.isHidden = true
        
        /*For on state*/
        mSwitch?.onTintColor = onColor
        
        /*For off state*/
        mSwitch?.tintColor = offColor
        mSwitch?.layer.cornerRadius = 16
        mSwitch?.backgroundColor = offColor
        
        if (self.arrayQues.count>0) {
            let category:String = self.arrayQues[indexPath.row]["category"] as! String
            let W : Int = 1
            let WIN = String(W)
            
            print(category)
            print(WIN)
            
            if (category == WIN){
                print("index=",indexPath.row)
                lblQues?.text = self.arrayQues[indexPath.row]["question"] as? String
                print("true")
            }else{
                lblQues?.text = nil
                print("false")
            }
        }

        
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4){
            mSwitch?.isOn = false
        }else if (indexPath.row == 3){
            mSwitch?.isHidden = true
            mview?.isHidden = false
        }else{
            
        }
        
        return cell
    }
}
extension String {
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
}

