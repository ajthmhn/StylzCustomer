//
//  LoginResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/20/24.
//

import Foundation
import StylesWebKit

struct LoginResourceEmail{
    
    func login(request: LoginRequestWithEmail, completionHandler:@escaping (_ isVerified:Bool, _ id:Int?, _ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.login(profDet: request.getLoginRequestBody()) { (aRes) in
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    let isVerfied = aRes?.json?["email_verified"].boolValue
                    let userID = aRes?.json?["userId"].intValue
                    
                    if let isVerfied, isVerfied ==  true
                    {
                        completionHandler(true, userID,nil)
                    }
                    else{
                        completionHandler(false,userID, LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.verifyYourEmaiil, comment: ""))
                    }
                    
                }
                else{
                    if let err = aRes?.json?["message"].stringValue, err != ""  {
                        completionHandler(false,nil,err)
                    }
                    else{
                        completionHandler(false, nil,
                                          LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                    }
                }
            }
            else{
                if let err = aRes?.json?["message"].stringValue, err != ""  {
                    completionHandler(false,nil,err)
                }
                else{
                    //print("this block will be executed")
                    completionHandler(false,nil, LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
                }
            }
        }
    }
}



