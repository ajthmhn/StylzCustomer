//
//  AddAddressRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation

struct AddAddressRequest {
    
    let _latitude: String
    let _longitude: String
    let nickName: String
    
    func getRequestBody() -> [String:Any]{
        
        var  details = [String:Any]()
        details["latitude"] = self._latitude
        details["longitude"] = self._longitude
        details["nick_name"] = self.nickName

        return details
    }
}



