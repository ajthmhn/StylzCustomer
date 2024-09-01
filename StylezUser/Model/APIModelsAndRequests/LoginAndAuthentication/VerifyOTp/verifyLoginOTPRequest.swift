//
//  verifyLoginOTPRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/23/24.
//

import Foundation

struct verifyLoginOTPRequest: Encodable {
    
    // let deviceToken:String
    let otp:Int
    let id: Int
    let isEmail:Bool
    var isUpadting:Bool
    var numOrEmail:String
    
    func getRequestBody() -> [String:Any]{
        var  details = [String:Any]()
        
        if isUpadting{
            
            if isEmail == true{
                details["email_change"] = true //only when using api for email change
                details["new_email"] = numOrEmail //only when using api for email change
            }
            else{
                details["phone_change"] = true //only when using api for phone change
                details["new_phone"] = numOrEmail //only when using api for phone change
            }
        }
        
        if isEmail == true{
            details["email_otp"] = otp
        }else{
            details["phone_otp"] = otp
        }
        
        details["user_id"] = id
        
        return details
    }
    
}


// "phone_change": true, //only when using api for phone change
// "new_phone": "31524014945", //only when using api for phone change
// "email_change": true, //only when using api for email change
// "new_email":"newemail@test.com" //only when using api for email change
