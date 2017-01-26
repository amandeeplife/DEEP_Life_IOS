//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: TestimonialDetailViewController
// Author Name		: Paul Prashant
// Date             : Oct, 21 2016
// Purpose			: Testimonial Detail View.
//>---------------------------------------------------------------------------------------------------

import UIKit

class TestimonialDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 220, 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
