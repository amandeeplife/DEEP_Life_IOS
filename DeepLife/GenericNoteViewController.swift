//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: GenericNoteViewController
// Author Name		: Paul Prashant
// Date             : Nov, 7 2016
// Purpose			: Generic Note View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class GenericNoteViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var noteView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(GenericNoteViewController.btnSaveDetails))
        self.navigationItem.rightBarButtonItem = save
        
        self.title = "Mike"
        
        bgView.backgroundColor = UIColor.white
        // corner radius
        bgView.layer.cornerRadius = 5
        // border
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        
        noteView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        noteView.isScrollEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        noteView.isScrollEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnSaveDetails() {
        print("save details")
        
        _ = navigationController?.popViewController(animated: true)
    }

}
