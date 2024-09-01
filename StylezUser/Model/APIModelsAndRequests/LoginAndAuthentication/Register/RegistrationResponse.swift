//
//  RegistrationResponse.swift
//  StylezUser
//
//  Created by MACBOOK on 2/22/24.
//

import Foundation

// MARK: - Welcome
struct RegistrationResponse: Codable {
   // let messageAr: String?
    let status: Int?
    let message: String?
    let phoneOtp, userID: Int?
    let token:String
    enum CodingKeys: String, CodingKey {
       // case messageAr = "message_ar"
        case status, message
        case phoneOtp = "phone_otp"
        case userID = "userId"
        case token = "token"
    }
}

