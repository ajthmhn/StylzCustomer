//
//  ForgotpasswordRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/23/24.
//

import Foundation
struct ForgotpasswordRequest: Encodable {
   
    let phone:String
    let isEmail:Bool
    
    func getRequestBody() -> [String:Any]{
       
        var  details = [String:Any]()
        
        if isEmail == true{
            details["email"] = phone
        }else{
            details["phone"] = phone
        }
      
        details["recovery_type"] = getRecoveryType()
        
        return details

    }
    
    func getRecoveryType()-> String{
        if isEmail {
            return "email"
        }
        else{
            return "phone"
        }
    }
    
}

