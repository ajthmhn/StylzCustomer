//
//  LogoutRequest.swift
//  StylezUser
//
//  Created by abcd on 24/03/2024.
//

import Foundation

struct LogoutRequest {
    
    let token: String
    
    func getRequestBody() -> [String:Any]{
        var profDic = [String:Any]()
        profDic["token"] = token
        
        return profDic
    }
    
}
