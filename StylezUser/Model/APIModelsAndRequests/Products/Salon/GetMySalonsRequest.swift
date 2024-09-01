//
//  GetMySalonsRequest.swift
//  StylezUser
//
//  Created by mac on 14/03/2024.
//

import Foundation

struct GetMySalonsRequest {
    
    let gender: Int
    
    func getRequestBody() -> Int{
        return  gender
    }
}



