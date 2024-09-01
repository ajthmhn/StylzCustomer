//
//  VerifyLoginOTPResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/23/24.
//

import Foundation
import StylesWebKit
import SwiftyJSON

struct VerifyLoginOTPResource{
    
    func verifyLoginOtp(request: verifyLoginOTPRequest, completionHandler:@escaping ( _ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.verifyLoginOtp(profDet: request.getRequestBody()) { (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
               
                    if request.isUpadting == false {
                        if  !request.isEmail && aRes?.json?["phone_verification_status"].boolValue == true{
                            completionHandler(nil)
                        }
                        else if request.isEmail && aRes?.json?["email_verification_status"].boolValue == true {
                            completionHandler(nil)
                        }
                        else{
                            completionHandler(
                                LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                        }
                    }else{
                        completionHandler(nil)
                    }
                }
                else{
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

