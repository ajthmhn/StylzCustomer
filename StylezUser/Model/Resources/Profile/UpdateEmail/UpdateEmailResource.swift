//
//  UpdateEmailResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation
import StylesWebKit

struct UpdateEmailResource{
    
    func updateEmail(request: UpdateEmailRequest, completionHandler:@escaping (_ otp: String?, _ userID:Int?, _ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.updateEmail(profDet: request.getRequestBody()) { (aRes) in
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    if let data = aRes?.json?["data"].dictionary{
                        
                        let otp =  data["email_otp"]?.stringValue ?? ""
                        let userId =  data["user_id"]?.intValue ?? 0
                        
                        if (otp != "" && userId != 0 && otp != nil && userId != nil ){
                            completionHandler(otp,userId,nil)
                        }
                        else{
                            completionHandler(nil,nil,LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                        }
                    }}
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

