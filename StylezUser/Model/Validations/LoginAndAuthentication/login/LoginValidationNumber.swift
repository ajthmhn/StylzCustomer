//
//  LoginValidationNumber.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation

extension LoginValidation  {
    
    func validateNumber(request: LoginRequestWithNumber) -> ValidationResult {
        if(request.number.count > 0 ){
                return ValidationResult(success: true, errorMessage: nil)
        }
        else{
          if request.number.count <= 0{
              return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
            }
        }

        return ValidationResult(success: false, errorMessage: K.Error.someThingWentWrong)
    }
    
}
