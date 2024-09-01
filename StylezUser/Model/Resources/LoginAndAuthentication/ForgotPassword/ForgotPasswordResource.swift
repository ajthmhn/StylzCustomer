//
//  ForgotPasswordResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/23/24.
//

import Foundation

import Foundation
import StylesWebKit
import SwiftyJSON

struct ForgotPasswordResource{
    
    func forgotPassword(request: ForgotpasswordRequest, completionHandler:@escaping (_ id:Int?, _ otp:String?, _ msg: String?)->()) {
        
        StylzAPIFacade.shared.forgotPassword(profDet: request.getRequestBody()) { (aRes) in
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    let otp =  aRes?.json?["otp"].stringValue ?? ""
                    let userID = aRes?.json?["user_id"].intValue ?? 0
                    let msg = aRes?.json?["message"].stringValue ?? ""
                    
                    completionHandler(userID,otp,msg)
                    
                }
                else{
                    if let err = aRes?.json?["message"].stringValue, err != ""  {
                        completionHandler(nil,nil,err)
                    }
                    else{
                        completionHandler(nil,nil,
                            LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                    }
                }
            }
            else{
                if let err = aRes?.json?["message"].stringValue, err != ""  {
                    completionHandler(nil,nil,err)
                }
                else{
                    //print("this block will be executed")
                    completionHandler(nil,nil, LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                }
            }
        }
    }
}

