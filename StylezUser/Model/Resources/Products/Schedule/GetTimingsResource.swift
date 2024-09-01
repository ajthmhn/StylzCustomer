//
//  GetTimingsResource.swift
//  StylezUser
//
//  Created by mac on 18/03/2024.
//

import Foundation
import StylesWebKit

struct GetTimingsResource{
    
    func checkAvailability(request:GetTimingsRequest,completionHandler:@escaping (_ timings:  [Timings]?,_ msg:String?)->()) {
        
        
        StylzAPIFacade.shared.checkAvailability(profDet: request.getRequestBody()){ (aRes) in
            
            if aRes?.statusCode == 200{
                
                if aRes?.json?["status"].intValue == 200{
                
                    var timings = [Timings]()
                    
                    if let data = aRes?.json?["data"].array{
                
                        for m in data{
                            let booking = Timings(json: m)
                            timings.append(booking)
                        }
                    }
                    
                    completionHandler(timings, nil)
                    
                }
                else{
                    completionHandler(nil, getErrMsg(json: aRes?.json))
                }
            }else{
                completionHandler(nil, getErrMsg(json: aRes?.json))
            }
        }
    }
}
