//
//  RegisterValidations.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation
struct RegisterValidations{
    
    func validate(request: RegisterRequest) -> ValidationResult {
    
        if(request.email.count > 0 && request.phone.count > 0 && request.firstName.count > 0  && request.password.count > 0 && request.ispolicyAccepted == true && request.fcm_id != ""){

            if(!request.email.validateEmail())
            {  return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
            }
            
            if (request.phone.count > 9){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.enterValidNum, comment: ""))
            }
            
            if (request.password.count < 8){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.passwordError, comment: ""))
            }
        
            
            return ValidationResult(success: true, errorMessage: nil)
        }
        else{
            if request.email.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))}
            
            if request.password.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_password", comment: ""))
            }
         
            if request.firstName.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_name", comment: ""))
            }
      
            if request.phone.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "PhoneIsRequired", comment: ""))
            }
            
         
//            if request.countryID == -1{
//                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_coutry", comment: ""))
//            }
            
         
            if request.ispolicyAccepted == false{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "accept_privacy", comment: ""))
            }
           
        }
        
        return ValidationResult(success: false, errorMessage:
                                LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
    }
    
}
