//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: NewsDetailViewController
// Author Name		: Paul Prashant
// Date             : Oct, 21 2016
// Purpose			: News Detail View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class NewsDetailViewController: UIViewController  {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDetail: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var imgText:String?
    var titleText:String?
    var detailText:String?
    var timeText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(imgText as Any)
        lblTitle.text = titleText
        lblDetail.text = detailText
        lblTime.text = timeText
        
        if (imgText?.isEmpty)! {
            print("No image url")
        }else{
            imgView.sd_setImage(with: URL(string: imgText!)!, placeholderImage: UIImage(named:"video-thumbnail")!)
        }
        
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGFloat(detailText!.stringlength/2), 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension String {
    var stringlength: Int { return self.characters.count }
}
