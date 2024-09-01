//
//  UpdateProfile.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import StylesWebKit

struct UpdateProfileResource{
    
    func updateProfile(request: UpdateProfileRequest, completionHandler:@escaping (_ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.updateProfile(profDet: request.getRequestBody() ) { (aRes) in
            
            //print("error: \(aRes?.json?["error"].stringValue)")
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    //  saveUserDetails(userDetails: (StylzAPIFacade.shared.session?.currentUser)!)
                    
                    completionHandler(nil)
                    
                } else{
                    if let err = aRes?.json?["message"].stringValue, err != ""  {
                        completionHandler(err)
                    }
                    else{
                        completionHandler(
                            LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                    }
                }
            }
            else{
                if let err = aRes?.json?["message"].stringValue, err != ""  {
                    completionHandler(err)
                }
                else{
                    //print("this block will be executed")
                    completionHandler( LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                }
            }
        }
    }
}

