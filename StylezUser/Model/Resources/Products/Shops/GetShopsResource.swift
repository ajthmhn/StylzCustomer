//
//  GetShopsResource.swift
//  StylezUser
//
//  Created by mac on 14/03/2024.
//

import Foundation
import StylesWebKit


struct GetShopsResource{
    
    func getBranches(request:GetShopsRequest,completionHandler:@escaping (_ salons: [Salons]?)->()) {
        
        StylzAPIFacade.shared.getBranches(gender: request.gender, lat: request.lat, lon: request.lon, customerID: request.customerID) { aRes in
            //print("inn get branches,")
            //print(aRes?.json)
           
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                   
                    var _salons = [Salons]()
                    
                    if let salons = aRes?.json?["shops"].array{
                        //print("fetching salons")
                        for m in salons{
                            let booking = Salons(json: m)
                            _salons.append(booking)
                        }
                    }
                    
                    completionHandler(_salons)
                }
                else
                {
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }
    }
}

