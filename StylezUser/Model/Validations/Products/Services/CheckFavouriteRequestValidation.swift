//
//  FavouriteValidation.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation

struct CheckFavouriteRequestValidation {
    
    func ValidateService(request: CheckFavouriteRequest) -> ValidationResult {
        
        if(request.id != 0){
            return ValidationResult(success: true, errorMessage: nil)
        }
        else{
            return ValidationResult(success: false, errorMessage: K.Error.someThingWentWrong)
        }
        
    }
}
