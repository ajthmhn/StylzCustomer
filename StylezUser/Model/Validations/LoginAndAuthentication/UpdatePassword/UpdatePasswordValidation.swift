//
//  UpdatePasswordValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/25/24.
//

import Foundation

struct UpdatePasswordValidation{
  
    
    func validate(request: UpdatePasswordRequest) -> ValidationResult {
        if(request.password.count > 0 && request.retypedPass.count > 0 && request.otp.count > 0 && request.userID != 0){
         
            if request.password != request.retypedPass{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password_missmatch", comment: ""))
               }
            
            if (request.retypedPass.count < 8){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.passwordError, comment: ""))
            }
        
            return ValidationResult(success: true, errorMessage: nil)
        }
        else{
            if  request.password.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_pass", comment: ""))}
            
            if  request.retypedPass.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "retype_pass", comment: ""))
            }
          }
        
        return ValidationResult(success: false, errorMessage: "Invalid details, please try again...")
    }
    
}
