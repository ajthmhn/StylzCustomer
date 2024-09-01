//
//  LoginRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/20/24.
//

import Foundation
struct LoginRequestWithEmail: Encodable {
   
    let userEmail, userPassword:String
    let deviceToken: String
  
    func getLoginRequestBody() -> [String:Any]{
      
        var  loginObj = [String:Any]()
        
        loginObj["email"] = userEmail
        loginObj["password"] = userPassword
        loginObj["user_type"] = 3
      
        loginObj["fcm_id"] = deviceToken
        
        return loginObj
    }
    
}

