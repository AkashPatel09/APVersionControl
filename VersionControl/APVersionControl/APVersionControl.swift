//
//  APVersionControl.swift
//  VersionControl
//
//  Created by Akash Patel on 15/03/19.
//  Copyright © 2019 AkashPatel. All rights reserved.
//

import UIKit

open class APVersionControl {
    
    /*
     This function checks whether your app's current version is higher than the version passed in parameter or not.
     This returns Boolean value. If returns FALSE means your app's current version is lower than the version value passed in a parameter and vise versa.
     */
    class func checkMyCurrentVersionIsHigherThan(_ versionString : String) -> Bool {
        let MyDeviceVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
        
        if versionString.compare(MyDeviceVersion,
                                   options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending {
            
            //versionString is higher
            return false
        }
        
        //Current version is compatible
        return true
    }
    
    /*
     This function help you to identify whether you need to display a force update alert dialog or not.
     This function checks whether your app's current version is lower than the version passed in parameters or not.
     This function returns a completion block having two boolean variables. The first boolean _needToShowUpdateDialog tells you that your app's current version is lower than the AppStore latest version you passed in parameter. In this case you can display update alert to user.
     The second boolean _isHavingForceUpdate tells you that the minimum required version you passed in parameter is heigher than your app's current version. In this case you can show force update dialog to user.
     */
    class func compareMyCurrentVersionWith(AppStoreVersion: String, MinimumVersionRequired: String, completion: @escaping (_ needToShowUpdateDialog : Bool, _ isHavingForceUpdate: Bool)->Void) {
        
        let MyDeviceVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
        
        if AppStoreVersion.compare(MyDeviceVersion,
                                   options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending {
            
            //AppStore version is higher
            if MinimumVersionRequired.isEmpty {
                completion(true, false)
            }
            if MinimumVersionRequired.compare(MyDeviceVersion,
                                              options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending {
                
                //MinimumVersionRequired is higher
                completion(true, true)
                
            } else {
                //CurrentVersion is compitable
                completion(true, false)
            }
            
        } else {
            
            //CurrentVersion is compitable
            completion(false, false)
        }
        
    }
}
