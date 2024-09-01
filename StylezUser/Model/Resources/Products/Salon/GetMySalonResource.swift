//
//  GetMySalonResource.swift
//  StylezUser
//
//  Created by mac on 14/03/2024.
//

import Foundation
import StylesWebKit


struct GetMySalonResource{
    
    func mySalons(request:GetMySalonsRequest,completionHandler:@escaping (_ salons: [Salons]?)->()) {
        
        StylzAPIFacade.shared.mySalons(gender: request.getRequestBody()) { (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    var _salons = [Salons]()
                    if let salons = aRes?.json?["data"].array{
                        for m in salons{
                            let booking = Salons(json: m)
                           _salons.append(booking)
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
