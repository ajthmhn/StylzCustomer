//
//  GetTop10SalonsResource.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import StylesWebKit

struct GetTop10SalonsResource{
    
    func top10Salons(request:GetTop10SalonsRequest,completionHandler:@escaping (_ salons: [Salons]?)->()) {
      
        StylzAPIFacade.shared.top10Salons(profDet: request.getRequestBody()){ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].boolValue == true{
                    
                    var _salons = [Salons]()
                    if let data = aRes?.json?["data"].dictionary{
                        if let salons = data["items"]?.array{
                            for m in salons{
                                let booking = Salons(json: m)
                                _salons.append(booking)
                            }
                        }
                    }
                    completionHandler(_salons)
                }else{
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }
    }
}
