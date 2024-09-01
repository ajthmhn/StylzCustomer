//
//  ChangePasswordResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
import StylesWebKit

struct ChangePasswordResource{
    
    func changePassword(request: ChangePasswordRequest, completionHandler:@escaping ( _ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.changePassword(profDet: request.getRequestBody()){ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    completionHandler(nil)
                }else{
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
                    completionHandler(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                }
            }
        }
    }
}


