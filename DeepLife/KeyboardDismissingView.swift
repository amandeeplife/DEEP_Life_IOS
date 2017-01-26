//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: KeyboardDismissingView
// Author Name		: Paul Prashant
// Date             : Jan, 5 2016
// Purpose			: Dismiss Keyboard while editing textfields.
//>---------------------------------------------------------------------------------------------------


import UIKit

@objc public class KeyboardDismissingView: UIView {
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        _ = KeyboardDismissingView.resignAnyFirstResponder(self)
    }
    
    public class func resignAnyFirstResponder(_ view: UIView) -> Bool {
        var hasResigned = false
        for subView in view.subviews {
            if subView.isFirstResponder {
                subView.resignFirstResponder()
                hasResigned = true
                if let searchBar = subView as? UISearchBar {
                    searchBar.setShowsCancelButton(false, animated: true)
                }
            }
            else {
                hasResigned = KeyboardDismissingView.resignAnyFirstResponder(subView) || hasResigned
            }
        }
        return hasResigned
    }
}
