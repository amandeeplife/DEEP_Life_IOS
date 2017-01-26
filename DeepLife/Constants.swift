//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: Constant
// Author Name		: Paul Prashant
// Date             : Oct, 3 2016
// Purpose			: Constants for later use in views.
//>---------------------------------------------------------------------------------------------------

import UIKit

struct Constant {
    //  Device IPHONE
    static let kIphone_4s : Bool =  (UIScreen.main.bounds.size.height == 480)
    static let kIphone_5 : Bool =  (UIScreen.main.bounds.size.height == 568)
    static let kIphone_6 : Bool =  (UIScreen.main.bounds.size.height == 667)
    static let kIphone_6_Plus : Bool =  (UIScreen.main.bounds.size.height == 736)
    
    
    static let deviceHeight = UIScreen.main.bounds.height
    static let deviceWidth = UIScreen.main.bounds.width
    static let statusBar = UIApplication.shared.statusBarFrame.size.height
    
    //   Constant Variable.
    static let base_url         =       "http://staging.deeplife.cc"
}
