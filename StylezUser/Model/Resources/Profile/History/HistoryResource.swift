//
//  HistoryResource.swift
//  StylezUser
//
//  Created by mac on 11/03/2024.
//

import Foundation
import StylesWebKit

struct HistoryResource{
    
    func orderHIstory(request:HistoryRequest,completionHandler:@escaping (_ appointments: [Appointments]?)->()) {
        
        StylzAPIFacade.shared.orderHIstory(gender: request.gender){ (aRes) in
            
            //print("in appointment history \(aRes?.json)")
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{

                    var orders = [Appointments]()
                    if let data = aRes?.json?["data"].array{
                     
                        for m in data{
                            let booking = Appointments(json: m)
                            orders.append(booking)
                        }
                    }
                    completionHandler(orders)
                }
                else{
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }
    }
}
