//
//  AddAddressRequestValidation.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation

struct AddAddressRequestValidation  {
    
    func validateAddress(request: AddAddressRequest) -> ValidationResult {
        if(request._latitude.count > 0 && request._longitude.count > 0 && request.nickName.count > 0 ){
                return ValidationResult(success: true, errorMessage: nil)
          }
        else{
            if request.nickName.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_nick", comment: ""))}
           
            
            if request._longitude.count <= 0 || request._longitude.count <= 0{
                return ValidationResult(success: false, errorMessage: K.MYStrings.chooseLoc)}
          
          }

        return ValidationResult(success: false, errorMessage: K.Error.someThingWentWrong)
    }
    
}
