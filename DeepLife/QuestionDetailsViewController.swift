//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: QuestionDetailsViewController
// Author Name		: Paul Prashant
// Date             : Nov, 9 2016
// Purpose			: Question Details View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class QuestionDetailsViewController: UIViewController {

    @IBOutlet weak var mSwitch: UISwitch!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var noteView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(QuestionDetailsViewController.btnSaveDetails))
        self.navigationItem.rightBarButtonItem = save

        self.title = "Mike"
        
        let onColor  = UIColor.green
        let offColor = UIColor.red
        
        /*For on state*/
        mSwitch.onTintColor = onColor
        
        /*For off state*/
        mSwitch.tintColor = offColor
        mSwitch.layer.cornerRadius = 16
        mSwitch.backgroundColor = offColor
        
        mSwitch.isOn = false
        mSwitch.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        bgView.backgroundColor = UIColor.white
        // corner radius
        bgView.layer.cornerRadius = 5
        // border
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        
        noteView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        // Do any additional setup after loading the view.
    }
    
    func btnSaveDetails() {
        print("save details")
        
        _ = navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
