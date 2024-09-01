//
//  NotificationResource.swift
//  StylezUser
//
//  Created by MACBOOK on 3/6/24.
//

import Foundation


import StylesWebKit

struct NotificationReosurce{
    
    func getNotifications(request:NotificationRequest,completionHandler:@escaping (_ notifications: [NOtifications]?)->()) {
        
        //print("~ page: \(request.getRequestBody().0), gender: \(request.getRequestBody().1)")
        
        StylzAPIFacade.shared.getNotifications(page: request.getRequestBody().0, gender: request.getRequestBody().1 )
        { (aRes) in
            
            if aRes?.statusCode == 200{
                
                if aRes?.json?["status"].intValue == 200{
                    var notifications = [NOtifications]()
                    
                    if let data = aRes?.json?["data"].array{
                        //print("~data: \(data)")
                        for m in data{
                            let booking = NOtifications(json: m)
                            notifications.append(booking)
                        }
                    }
                    completionHandler(notifications)
                }else{
                    completionHandler(nil)
                }
            }
            else{
                completionHandler(nil)
            }
        }
    }
}
