//
//  OTPValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation

struct OTPValidation{
    
    func validate(request: VerifyOTPRequest) -> ValidationResult {
    
        if request.isEmail == true, (request.email.count > 0 ){
        
            if(!request.email.validateEmail())
            {  return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
            }
            
            return ValidationResult(success: true, errorMessage: nil)
        }
        else if request.isEmail == false{
            
            if (request.phone.count <= 0 ){
               
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
            }
            
            if (request.phone.count > 9){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.enterValidNum, comment: ""))
            }
            
            return ValidationResult(success: true, errorMessage: nil)
        }
        
        
        return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
    }
    
}
