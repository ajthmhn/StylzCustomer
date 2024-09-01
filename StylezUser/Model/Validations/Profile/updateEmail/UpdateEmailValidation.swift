//
//  UpdateEmailValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation

struct UpdateEmailValidation  {
    
    func validateEmail(request: UpdateEmailRequest) -> ValidationResult {
        if(request.email.count > 0){
            if(request.email.validateEmail()){
                return ValidationResult(success: true, errorMessage: nil)
            }else{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
            }
        }
        else{
            //print("pass \(request.email), emai")
            
          if request.email.count <= 0{
              return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))}
        }

        return ValidationResult(success: false, errorMessage:
        LocalizationSystem
            .sharedInstance.localizedStringForKey(key:  K.Error.someThingWentWrong, comment: ""))
    }
    
}
