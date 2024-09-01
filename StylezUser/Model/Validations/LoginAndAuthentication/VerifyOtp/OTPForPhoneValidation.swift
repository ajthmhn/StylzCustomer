//
//  VerifyOTPForPhoneValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/22/24.
//

import Foundation

struct OTPForPhoneValidation{
    
    func validate(request: VerifyOTPForPhoneRequest) -> ValidationResult {
    
        if request.otp != 0 && request.phone.count > 0{
            //print("verify otp email validation true")
           
            if (request.phone.count < 9){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.enterValidNum, comment: ""))
            }
            
            return ValidationResult(success: true, errorMessage: nil)
        }
        else if request.otp == 0{
            
            //print("verify otp phone validation false")
       
            return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_otp", comment: ""))
         }
      
        return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
    }
    
}
