//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: PNPHighlightButton
// Author Name		: Paul Prashant
// Date             : Jan, 5 2016
// Purpose			: Helps select country from country list.
//>---------------------------------------------------------------------------------------------------

import UIKit

@IBDesignable
class PNPHighlightButton: UIButton {
    fileprivate var normalBackgroundColor: UIColor!
    
    @IBInspectable var highlightedBackgroundColor: UIColor = UIColor.lightGray
    
    override func awakeFromNib() {
        super.awakeFromNib()
        normalBackgroundColor = backgroundColor
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = highlightedBackgroundColor
            } else {
                backgroundColor = normalBackgroundColor
            }
        }
    }
}
