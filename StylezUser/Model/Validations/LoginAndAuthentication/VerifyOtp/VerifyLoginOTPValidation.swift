//
//  VerifyLoginOTPValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/23/24.
//

import Foundation

struct VerifyLoginOTPValidation{
    
    func validate(request: verifyLoginOTPRequest) -> ValidationResult {
        
        if request.otp != 0 && request.id != 0{
            
            if "\(request.otp)".count < 5{
                
                //print("~verify otp 3 phone validation false")
                
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "valid_otp", comment: ""))
            
            }
            
            //print("verify otp email validation true")
            return ValidationResult(success: true, errorMessage: nil)
        }
        else {
            
            if request.otp == 0{
                //print("verify 2 otp phone validation false")
                
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_otp", comment: ""))
            }
           
            
            //print("this will be executed otp \(request.otp), id: \(request.id)")
            return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
        }
    }
}
