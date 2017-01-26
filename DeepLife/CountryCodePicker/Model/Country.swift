//>---------------------------------------------------------------------------------------------------
// Page/Module Name	: Country
// Author Name		: Paul Prashant
// Date             : Jan, 5 2016
// Purpose			: Helps select country from country list.
//>---------------------------------------------------------------------------------------------------


import Foundation

public func ==(lhs: Country, rhs: Country) -> Bool {
    return lhs.countryCode == rhs.countryCode
}

open class Country: NSObject {
    open static var emptyCountry: Country { return Country(countryCode: "", phoneExtension: "", isMain: true) }
    
    open static var currentCountry: Country {
        if let countryCode = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String {
            return Countries.countryFromCountryCode(countryCode)
        }
        return Country.emptyCountry
    }
    
    open var countryCode: String
    open var phoneExtension: String
    open var isMain: Bool
    
    public init(countryCode: String, phoneExtension: String, isMain: Bool) {
        self.countryCode = countryCode
        self.phoneExtension = phoneExtension
        self.isMain = isMain
    }
    
    @objc open var name: String {
        return (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode) ?? "Invalid country code"
    }
}
