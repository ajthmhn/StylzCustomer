//
//  ChnagePassValidationAndResourceHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
struct ChangePassViewModel{
    
    func changePassword(request: ChangePasswordRequest, completionHandler:@escaping ( _ errorMsg: String?)->()) {
      
        let validation = ChangePasswordValidation()
        
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
        
            let resource = ChangePasswordResource()
            
            resource.changePassword(request: request) { errorMsg in
            
            completionHandler(errorMsg)
            }
        }
        else{
            
            completionHandler(validationResult.errorMessage ?? "")
        }
    }
}
