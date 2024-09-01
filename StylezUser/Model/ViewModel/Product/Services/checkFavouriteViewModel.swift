//
//  FavouriteViewModel.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation
import StylesWebKit

// this validation is not actually requried
struct CheckFavouriteViewModel{
    
   private let validation = CheckFavouriteRequestValidation()
   private let resource = CheckFavouriteResource()
 
    func checkFavourite(request: CheckFavouriteRequest, completionHandler:@escaping (_ favCode:Int,_ err:String?) -> ()) {
        
        let validationResult = validation.ValidateService(request: request)
        
        if validationResult.success{
            
            resource.checkFavourite(request: request) { favCode in
                
                completionHandler(favCode, nil)
            }
        }
        else{
            completionHandler(0, validationResult.errorMessage)
        }
    }
}

