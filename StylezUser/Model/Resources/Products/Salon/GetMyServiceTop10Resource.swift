//
//  GetMyServices.swift
//  StylezUser
//
//  Created by mac on 14/03/2024.
//

import Foundation
import StylesWebKit

// used in salon view controller
struct GetMyServiceResource_top10Salons{
    
    func myServices_top10Salons(request:ServicesRequest,completionHandler:@escaping (_ salons: [Salons]?, _ errorMsg:String?)->()) {
        
        StylzAPIFacade.shared.top10Salons(profDet: request.getRequestBody()){ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].boolValue == true{
                    
                    var _salon = [Salons]()
                    
                    if let data = aRes?.json?["data"].dictionary{
                        if let salons = data["items"]?.array{
                            for m in salons{
                                let booking = Salons(json: m)
                                _salon.append(booking)
                            }
                        }
                    }
                    //print("~salon count \(_salon.count)")
                    completionHandler(_salon, nil)
                }
                else{
                    
                    if let err = aRes?.json?["message"].stringValue, err != ""{
                        completionHandler(nil,  err)
                    }
                    else{
                        completionHandler(nil, K.Error.someThingWentWrong)
                    }
                }
            }
            else{
                completionHandler(nil, K.Error.someThingWentWrong)
            }
        }
    }
}
