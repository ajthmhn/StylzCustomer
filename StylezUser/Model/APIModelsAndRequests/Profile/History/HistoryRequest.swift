//
//  GetHistoryRequest.swift
//  StylezUser
//
//  Created by mac on 11/03/2024.
//

import Foundation

struct HistoryRequest {
    
    let gender: Int
    
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        details["gender"] = gender
        return details
    }
    
    
}


