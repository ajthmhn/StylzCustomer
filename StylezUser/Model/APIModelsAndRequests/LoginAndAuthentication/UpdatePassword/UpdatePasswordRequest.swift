//
//  UpdatePasswordRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/25/24.
//


import Foundation

struct UpdatePasswordRequest: Encodable {
   
    let otp:String
    let userID:Int
    let password:String
    let retypedPass:String
    
    func getRequestBody() -> [String:Any]{
        
        var  details = [String:Any]()
        
        details["otp"] = self.otp
        details["user_id"] = self.userID
        details["new_password"] = password
        details["purpose"] = "forgot_password"
        
        return details
    }
    
    
}

