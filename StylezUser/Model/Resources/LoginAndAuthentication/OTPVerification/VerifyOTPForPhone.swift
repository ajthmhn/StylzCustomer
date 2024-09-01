//
//  VerifyOTPForPhone.swift
//  StylezUser
//
//  Created by MACBOOK on 2/22/24.
//


import Foundation
import StylesWebKit
import SwiftyJSON

struct VerifyOTPForPhoneResource{
    
    func verifyOTP(request: VerifyOTPForPhoneRequest, completionHandler:@escaping (_ errorMsg: String?)->()) {
        
        //print(request.getRequestBody())
        
        StylzAPIFacade.shared.quickLoginVerifyOtp(profDet: request.getRequestBody()) { (aRes) in
            //print(aRes?.json)
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    completionHandler(nil)
                }
                else{
                    //   showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
                    if let err = aRes?.json?["message"].stringValue, err != ""  {
                        completionHandler(err)
                    }
                    else{
                        completionHandler(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))}
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

