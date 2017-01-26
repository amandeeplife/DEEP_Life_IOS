//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: MenuViewController
// Author Name		: Paul Prashant
// Date             : Oct, 13 2016
// Purpose			: Show Slide menu items.
//>---------------------------------------------------------------------------------------------------


import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    @available(iOS 2.0, *)
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
    @IBOutlet weak var imgView: UIImageView!
//    }

    
    /**
    *  Array to display menu options
    */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        
        let image : UIImage = UIImage(named: "placeholder")!
        imgView?.image = image.circle
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Profile", "icon":"profile black"])
        arrayMenuOptions.append(["title":"About Deeplife", "icon":"deeplife black"])
        //arrayMenuOptions.append(["title":"Setting", "icon":"gear black"])
        arrayMenuOptions.append(["title":"Logout", "icon":"logout black"])
        
        tblMenuOptions.reloadData()
    }
    

    @IBAction func onCloseMenuClick(_ sender: UIButton) {
        btnMenu.tag = 0
        print("onCloseMenuClick-button")
        if (self.delegate != nil) {
            var index = Int32(sender.tag)
            if(sender == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index: index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x:-UIScreen.main.bounds.size.width, y:0, width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }
    @IBAction func onCloseMenuClick(button:UIButton!){
        btnMenu.tag = 0
        print("onCloseMenuClick-button")
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index: index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x:-UIScreen.main.bounds.size.width, y:0, width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(1001) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(1000) as! UIImageView
        
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(button: btn)
        print("onCloseMenuClick")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
}
