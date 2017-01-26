//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: EditProfileViewController
// Author Name		: Paul Prashant
// Date             : Dec, 28 2016
// Purpose			: Edit User Profile.
//>---------------------------------------------------------------------------------------------------


import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Profile"
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(EditProfileViewController.btnDismissVC))
        self.navigationItem.leftBarButtonItem = cancel
        
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(EditProfileViewController.btnSaveProfile))
        self.navigationItem.rightBarButtonItem = save
        
        
        let image : UIImage = UIImage(named: "placeholder")!
        profilePic.image = image.circle
        
        // Do any additional setup after loading the view.
    }
    
    func btnSaveProfile() {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func btnDismissVC() {
        
        _ = navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
