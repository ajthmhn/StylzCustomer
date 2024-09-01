//
//  ForgotPasswordViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
struct ForgotPasswordViewModel{
    
    
    func forgotPassword(request: ForgotpasswordRequest, completionHandler:@escaping (_ id:Int?, _ otp:String?, _ errorMsg: String?)->()) {
        
        let validation = ForgotPasswordValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            let resource = ForgotPasswordResource()
            
            resource.forgotPassword(request: request){id, otp, errorMsg in
                    //print("~got verify otp response otp: \(otp)")
                    completionHandler(id, otp,errorMsg)
            }
        }
        else{
            completionHandler(nil,nil, validationResult.errorMessage)
        }
        
        
    }
    
    
}
