//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: AboutViewController
// Author Name		: Paul Prashant
// Date             : Dec, 28 2016
// Purpose			: About Deeplife.
//>---------------------------------------------------------------------------------------------------


import UIKit

class AboutViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var myWebView: UIWebView!
    var urlString :String = Constant.base_url + "/#about"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Show the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "About Deeplife"
        
        let reload = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(AboutViewController.btnReloadVC))
        self.navigationItem.rightBarButtonItem = reload

        self.showMBProgressHUD()
        
        myWebView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)
        myWebView.delegate = self
        print(urlString)
        // Do any additional setup after loading the view.
    }

    func btnReloadVC() {
        print("reload")
        myWebView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)
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
    

    func webViewDidStartLoad(_ webView : UIWebView) {
        print("webViewDidStartLoad")
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        print("webViewDidFinishLoad")
        self.hideMBProgressHUD()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Webview fail with error \(error)");
        self.hideMBProgressHUD()
        
        let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
