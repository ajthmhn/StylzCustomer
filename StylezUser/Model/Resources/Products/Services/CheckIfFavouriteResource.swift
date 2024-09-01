//
//  FavouriteResource.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation
import StylesWebKit

struct CheckFavouriteResource{
    
    func checkFavourite(request:CheckFavouriteRequest,completionHandler:@escaping (_ favCode:  Int)->()) {
        
        let requestData = request.getRequestBody()
        let gender = requestData.1
        let id = requestData.0
        
        StylzAPIFacade.shared.checkFavourite(id: id , gender: gender){ (aRes) in
            if aRes?.statusCode == 200{
                var isFav = 0
                if aRes?.json?["status"].intValue == 200{
               
               if let isFavStatus = aRes?.json?["is_favorite"].boolValue
                {
                   if isFavStatus{
                       isFav = 1
                   }else{
                       isFav = 0
                   }
               }
                completionHandler(isFav)
             
            }
                
            }else{
                completionHandler(0)
            }
        }
    }
}
