//
//  VerifyOTPResponse.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation


// MARK: - Welcome
struct VerifyOTPResponse: Codable {
    let message, messageAr: String?
    let status: Bool?
    let data: VerifyOTPDataClass?

    enum CodingKeys: String, CodingKey {
        case message
        case messageAr = "message_ar"
        case status, data
    }
}

// MARK: - DataClass
struct VerifyOTPDataClass: Codable {
    let userID:Int?

  //emailOtp: Int?
   // let phoneOtp: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
     //   case emailOtp = "email_otp"
     ///   case phoneOtp = "phone_otp"
    }
}
