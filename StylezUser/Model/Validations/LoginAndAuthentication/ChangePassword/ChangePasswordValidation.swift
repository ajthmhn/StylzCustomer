//
//  ChangePasswordValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation

struct ChangePasswordValidation{
    
    func validate(request: ChangePasswordRequest) -> ValidationResult {
     
        if(request.password.count > 0 && request.oldPassword.count > 0 && request.confirmPass.count > 0){
            
            if request.password != request.confirmPass{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password_missmatch", comment: ""))
            }
           
            if (request.confirmPass.count < 8){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.passwordError, comment: ""))
            }
        
        
            return ValidationResult(success: true, errorMessage: nil)
        }
        else
        {
            if  request.oldPassword.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_current", comment: ""))} // can give a custom msg for old pass
            
            if  request.password.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_pass", comment: ""))}
            
            if  request.confirmPass.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "retype_pass", comment: ""))}
            
            
        }
        
        return ValidationResult(success: false, errorMessage:LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
    }
    
}
