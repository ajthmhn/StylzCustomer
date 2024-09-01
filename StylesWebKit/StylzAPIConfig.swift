
//  StylzAPIConfig.swift
//  PartyManager
//
//  Created by islet on 14/12/16.
//  Copyright © 2016 islet. All rights reserved.
//

import UIKit

public class StylzAPIConfig: NSObject {
    
    public struct Notifications {
        
        public static let sessionExpired = "api.sessionId.expired"
        
    }
    
public struct BaseUrl {
  
//    Stylz staging api url:https://staging.stylz.me/api
//    Stylz live api url:https://dashboard.stylz.me/api
    
//    Stylz staging api url:https://staging.stylz.me/api
//    Stylz live api url:https://dashboard.stylz.me/api
    
    //https://staging.stylz.me/api/
 //  public static let baseServerpath = "https://dashboard.stylz.me/" //old server
 //   public static let baseServerpath = "https://staging.stylz.me/" //old server
    
    public static let baseServerpath = "http://18.221.228.169" //new staging server
  
    public static let imageBaseServerpath = ""

    }
}

