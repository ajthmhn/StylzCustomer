//
//  UpdateProfileViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation

struct UpdateEmailViewModel{
    
    func updateEmail(request: UpdateEmailRequest, completionHandler:@escaping  (_ otp: String?, _ userID:Int?, _ errorMsg: String?)->())
    {
        let validation = UpdateEmailValidation()
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            
            let resource = UpdateEmailResource()
         
            resource.updateEmail(request: request){ otp, userID, errorMsg in
                
            completionHandler(otp, userID, errorMsg)
           
            }
        }
        else{
            completionHandler(nil,nil, validationResult.errorMessage)
            
        }
    }
}
