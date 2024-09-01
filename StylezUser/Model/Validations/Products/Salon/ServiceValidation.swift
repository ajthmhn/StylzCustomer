//
//  ServiceValidation.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import Foundation

struct ServiceValidation  {
    
    func ValidateService(request: ServicesRequest) -> ValidationResult {
      
        if(request.lat != 0.0 && request.lon != 0.0 && request.serviceId != 0){
                return ValidationResult(success: true, errorMessage: nil)
            }
        else{
            
            if request.lat == 0.0 ||  request.lon == 0.0 {
            return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.noLocation, comment: ""))}
            }
       
        
        return ValidationResult(success: false, errorMessage: K.Error.someThingWentWrong)
    }
    
}
