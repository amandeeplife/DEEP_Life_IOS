//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: ForgotViewController
// Author Name		: Paul Prashant
// Date             : Jan, 7 2016
// Purpose			: Recover password.
//>---------------------------------------------------------------------------------------------------


import UIKit

class ForgotViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var myWebView: UIWebView!
    var urlString :String = Constant.base_url + "/forgot"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Show the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ForgotViewController.btnDismissVC))
        self.navigationItem.leftBarButtonItem = cancel
        
        let reload = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(ForgotViewController.btnReloadVC))
        self.navigationItem.rightBarButtonItem = reload

        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Loading..."
        
        myWebView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)
        myWebView.delegate = self
        print(urlString)
        // Do any additional setup after loading the view.
    }

    func btnDismissVC() {
        print("dismiss")
       _ = self.navigationController?.popViewController(animated: true)
    }
    func btnReloadVC() {
        print("reload")
        myWebView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)
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
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Webview fail with error \(error)");
        MBProgressHUD.hide(for: self.view, animated: true)
        
        let alert = UIAlertController(title: "Sorry", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
