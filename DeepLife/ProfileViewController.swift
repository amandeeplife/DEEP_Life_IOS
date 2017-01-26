//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: ProfileViewController
// Author Name		: Paul Prashant
// Date             : Dec, 28 2016
// Purpose			: Show User Profile.
//>---------------------------------------------------------------------------------------------------

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ProfileViewController.btnEditDetails))
        self.navigationItem.rightBarButtonItem = edit
        
        let image : UIImage = UIImage(named: "placeholder")!
        profilePic.image =  image.circle
        
        // Do any additional setup after loading the view.
    }
    
    func btnEditDetails() {
        print("edit profile")
        performSegue(withIdentifier: "showEditProfile", sender: nil)
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
