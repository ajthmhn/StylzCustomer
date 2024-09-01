//
//  GetAllBarbersResource.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import StylesWebKit

struct GetAllBarbersResource{
    
    func allBarbers(request:GetAllBArbersRequest,completionHandler:@escaping (_ salons: [Salons]?)->()) {
        
        StylzAPIFacade.shared.allBarbers(profDet: request.getRequestBody()){ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].boolValue == true{
                    var allBarbers = [Salons]()
                    
                    if let data = aRes?.json?["data"].dictionary{
                        if let salons = data["items"]?.array{
                            for m in salons{
                                let booking = Salons(json: m)
                                allBarbers.append(booking)
                            }
                        }
                    }
                    completionHandler(allBarbers)
                }
                else{
                    // showAlert(title: "", subTitle:  aRes?.json?["message"].stringValue ?? "" , sender: self)
                    completionHandler(nil)
               }
            }
            else{
                completionHandler(nil)
            }
        }
    }
    
}
