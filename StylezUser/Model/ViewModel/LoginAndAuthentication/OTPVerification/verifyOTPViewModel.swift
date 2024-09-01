//
//  verifyOTPViewModel.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation

struct verifyOTPViewModel{
    
    func sendOtpLogin(request: VerifyOTPRequest, completionHandler:@escaping (_ otp:Int?, _ errorMsg: String?)->()) {
        
        let validation = OTPValidation()
        
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = VerifyOTPResource()
            
            resource.sendOtpLogin(request: request) {otp, errorMsg  in
             
                completionHandler(otp,errorMsg)
            }
        }
        else{
            
            completionHandler(nil,validationResult.errorMessage)
        }
    }
}
