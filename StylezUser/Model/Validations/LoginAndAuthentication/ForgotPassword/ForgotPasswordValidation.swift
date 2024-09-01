//
//  ForgotPasswordValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/23/24.
//

import Foundation
struct ForgotPasswordValidation{
    
    func validate(request: ForgotpasswordRequest) -> ValidationResult {
        if(request.phone.count > 0 ){
            if(request.isEmail == false)
            {
                if (request.phone.count > 9){
                    return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.enterValidNum, comment: ""))
                }
                
                return ValidationResult(success: true, errorMessage: nil)
            }
            else{
                if(!request.phone.validateEmail())
                {  return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
                }
                
                return ValidationResult(success: true, errorMessage: nil)
               
            }
        }
        else{
            if request.isEmail == true && request.phone.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))}
            
            if request.isEmail == false && request.phone.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
            }
          }
        
        return ValidationResult(success: false, errorMessage: "Please enter valid details")
    }
    
}
