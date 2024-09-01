//
//  UpdateNumberValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation

struct UpdateNumberValidation  {
    
    func validateNumber(request: UpdateNumberRequest) -> ValidationResult {
        if(request.number.count > 0){
            if (request.number.count > 9){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.enterValidNum, comment: ""))
            }
           
            return ValidationResult(success: true, errorMessage: nil)
          }
        
        else{
          if request.number.count <= 0{
              return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))}
        }

        return ValidationResult(success: false, errorMessage: K.Error.someThingWentWrong)
    }
    
}
