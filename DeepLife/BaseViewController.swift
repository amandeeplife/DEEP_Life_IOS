//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: BaseViewController
// Author Name		: Paul Prashant
// Date             : Oct, 13 2016
// Purpose			: Show Slide menu.
//>---------------------------------------------------------------------------------------------------

import UIKit

class BaseViewController: UIViewController, SlideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideMenuItemSelectedAtIndex(index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        switch(index){
        case 0:
            print("Profile\n", terminator: "")

            self.openViewControllerBasedOnIdentifier(strIdentifier: "ProfileVC")
            
            break
        case 1:
            print("About Deeplife\n", terminator: "")
            
            self.openViewControllerBasedOnIdentifier(strIdentifier: "AboutVC")
            
            break
//        case 2:
//            print("Settings\n", terminator: "")
//            
//            self.openViewControllerBasedOnIdentifier(strIdentifier: "SettingVC")
//            
//            break
        case 2:
            print("Logout\n", terminator: "")
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "country")
            UserDefaults.standard.synchronize()
            
            self.openViewControllerBasedOnIdentifier(strIdentifier: "LoginVC")
            
            break
        default:
            print("default\n", terminator: "")
        }
    }
    
    func openViewControllerBasedOnIdentifier(strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        //let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (view.subviews.last?.restorationIdentifier == "SlideMenuView"){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState.normal)
        btnShowMenu.frame = CGRect(x:0, y:0, width:30, height:30)
        btnShowMenu.addTarget(self, action: #selector(self.onSlideMenuButtonPressed), for: .touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }

    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:30, height:22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x:0, y:3, width:30, height:1)).fill()
        UIBezierPath(rect: CGRect(x:0, y:10, width:30, height:1)).fill()
        UIBezierPath(rect: CGRect(x:0, y:17, width:30, height:1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x:0, y:4, width:30, height:1)).fill()
        UIBezierPath(rect: CGRect(x:0, y:11,  width:30, height:1)).fill()
        UIBezierPath(rect: CGRect(x:0, y:18, width:30, height:1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
       
        return defaultMenuImage;
    }
    
    func onSlideMenuButtonPressed(sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(index: -1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
                }, completion: { (finished) -> Void in
                    viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x:0 - UIScreen.main.bounds.size.width, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height);
            sender.isEnabled = true
            }, completion:nil)
    }
}
