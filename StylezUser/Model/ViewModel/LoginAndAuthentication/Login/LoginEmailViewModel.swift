//
//  LoginEmailViewMode.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation

struct LoginEmailViewModel{
    
    func login(request: LoginRequestWithEmail, completionHandler:@escaping (_ isVerified:Bool ,_ id:Int?, _ errorMsg: String?)->()) {
        
        let validation = LoginValidation()
       
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            
            let resource = LoginResourceEmail()
            resource.login(request: request) { isVerified, id, errorMsg  in
                completionHandler(isVerified,id,errorMsg)
            }
        }
        else{
            completionHandler(false,nil,validationResult.errorMessage)
        }
    }
}
