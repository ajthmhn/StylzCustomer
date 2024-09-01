//
//  CategeoryResource.swift
//  StylezUser
//
//  Created by mac on 11/03/2024.
//


import Foundation
import StylesWebKit

struct CategeoryResource{
    
    func getCategory(request:CategoryRequest,completionHandler:@escaping (_ categories: [Categories]?,_ errorMsg:String?)->()) {
        
        StylzAPIFacade.shared.getCategory(gender: request.gender,keyValue: request.keyValue,key:request
            .getFilerKey()) { (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    var categories = [Categories]()
                    
                    if let data = aRes?.json?["categories"].array{
                        for m in data{
                            let booking = Categories(json: m)
                            categories.append(booking)
                        }
                    }
                    completionHandler(categories, nil)
                    
                }else{
                    completionHandler(nil , aRes?.json?["message"].stringValue ?? K.Error.someThingWentWrong)
                }
            }
                else{
                    completionHandler(nil , aRes?.json?["message"].stringValue ?? K.Error.someThingWentWrong)
                }
        }
    }
}
