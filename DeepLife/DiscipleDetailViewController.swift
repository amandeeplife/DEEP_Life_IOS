//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: DiscipleDetailViewController
// Author Name		: Paul Prashant
// Date             : Oct, 25 2016
// Purpose			: Profile View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class DiscipleDetailViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(DiscipleDetailViewController.btnEditDetails))
        self.navigationItem.rightBarButtonItem = edit
        
        let image : UIImage = UIImage(named: "placeholder")!
        profilePic.image =  image.circle
        
        // Do any additional setup after loading the view.
    }
    
    func btnEditDetails() {
        print("edit details")
        
        performSegue(withIdentifier: "editDisciple", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
