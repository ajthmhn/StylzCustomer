//
//  ChangePasswordRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
//
//  UpdatePasswordRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/25/24.
//


import Foundation

struct  ChangePasswordRequest: Encodable {
    let password:String
    let confirmPass:String
    let oldPassword:String

    func getRequestBody() -> [String:Any]{
        var details = [String:Any]()
        details["old_password"] = oldPassword
        details["new_password"] = password
       
        return details
    }
}

