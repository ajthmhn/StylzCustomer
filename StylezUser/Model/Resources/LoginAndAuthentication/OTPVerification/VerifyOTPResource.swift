//
//  VerifyOTPResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation
import StylesWebKit
import SwiftyJSON

struct VerifyOTPResource{
    
    func sendOtpLogin(request: VerifyOTPRequest, completionHandler:@escaping ( _ otp:Int?, _ Msg: String?)->()) {
        
        StylzAPIFacade.shared.sendOtpLogin(profDet: request.getRequestBody()) { (aRes) in
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    let otp = getOTPFromResponse(json: aRes?.json, isEmail: request.isEmail)
                    let msg = aRes?.json?["message"].stringValue
                   
                    completionHandler(otp,msg)
                }
                else{
                    if let err = aRes?.json?["message"].stringValue, err != ""  {
                        completionHandler(nil,err)
                    }
                    else{
                        completionHandler( nil,
                                           LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                    }
                }
            }
            else{
                if let err = aRes?.json?["message"].stringValue, err != ""  {
                    completionHandler(nil,err)
                }
                else{
                    //print("this block will be executed")
                    completionHandler(nil, LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                }
            }
        }
        
    }
    
    func getOTPFromResponse(json:JSON?, isEmail:Bool) -> Int?{
        var otp:Int? = nil
        
        if isEmail {
            otp =  json?["email_otp"].intValue
        }
        else{
            otp =  json?["phone_otp"].intValue
        }
        
        return otp
    }
}

