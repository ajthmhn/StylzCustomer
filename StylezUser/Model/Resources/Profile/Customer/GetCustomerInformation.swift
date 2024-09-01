//
//  GetCustomerInformation.swift
//  StylezUser
//
//  Created by mac on 22/03/2024.
//

import Foundation
import StylesWebKit

struct GetCustomerInformation{
    
    func getCustomerInformation(completionHandler:@escaping (_ err:  String?)->()) {
        
        
        StylzAPIFacade.shared.getCustomerInformation{ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    saveUserDetails(userDetails: (StylzAPIFacade.shared.session?.currentUser)!)
                  
                    completionHandler(nil)
                }else{
                    completionHandler(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                }
            }else{
                completionHandler(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
            }
        }
    }
}
