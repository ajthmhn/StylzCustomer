//
//  LoginResponseWithNum.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation

// MARK: - Welcome
struct LoginResponseWithNum: Codable {
    let status: Bool
    let messageAr, message: String
    let data: LoginNumDataClass

    enum CodingKeys: String, CodingKey {
        case status
        case messageAr = "message_ar"
        case message, data
    }
}

// MARK: - DataClass
struct LoginNumDataClass: Codable {
    let userID, otp: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case otp
    }
}
