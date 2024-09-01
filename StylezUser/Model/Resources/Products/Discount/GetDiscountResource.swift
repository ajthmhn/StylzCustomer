//
//  getDiscountResource.swift
//  StylezUser
//
//  Created by abcd on 15/04/2024.
//

import Foundation

import StylesWebKit
import SwiftyJSON


struct GetDiscountResource{
    
    func getDiscount(completionHandler:@escaping (_ discountValue:Double?, _ errorMsg:String?)->()) {
        
        //need to make cchanges here 
        StylzAPIFacade.shared.getDiscount{ (aRes) in
            
            if aRes?.statusCode == 200{
                var discountValue:Double? = nil
              
                if let data = aRes?.json?["data"].array{
                    for discount in data{
                        discountValue = discount["setting_value"].doubleValue
                        break
                    }
                }
                
                completionHandler(discountValue, LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
            }
            else{
                completionHandler(nil,getErrMsg(json: aRes?.json))
            }
        }
    }
}

