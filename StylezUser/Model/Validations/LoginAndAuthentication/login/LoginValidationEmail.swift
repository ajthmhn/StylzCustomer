//
//  LoginValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/20/24.
//

import Foundation

struct LoginValidation  {
    
    func validateEmail(request: LoginRequestWithEmail) -> ValidationResult {
        if(request.userEmail.count > 0 && request.userPassword.count > 0){
          
            
            
            if(!request.userEmail.validateEmail())
            {  return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
            }
            
//            if (request.userPassword.count < 8){
//                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.passwordError, comment: ""))
//            }
        
            
            return ValidationResult(success: true, errorMessage: nil)
           
        }
        else{
          
            //print("pass \(request.userPassword), email \(request.userEmail))")
            
          if request.userEmail.count <= 0{
              return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))
            }
            
        if request.userPassword.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_passwrd", comment: ""))
            }
        }

        return ValidationResult(success: false, errorMessage: K.Error.someThingWentWrong)
    }
    
}
