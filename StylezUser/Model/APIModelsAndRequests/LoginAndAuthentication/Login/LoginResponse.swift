//
//  LoginResponse.swift
//  StylezUser
//
//  Created by MACBOOK on 2/20/24.
//

import Foundation

// MARK: - Welcome
struct LoginResponse: Codable {
    let messageAr, message: String?
    let status: Bool?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case messageAr = "message_ar"
        case message, status, data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let userType: Int?
    let token: String?
    let phoneVerificationStatus: Bool?
    let userDetails: UserDetails?
    let emailVerificationStatus: Bool?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case token
        case phoneVerificationStatus = "phone_verification_status"
        case userDetails = "user_details"
        case emailVerificationStatus = "email_verification_status"
        case userID = "user_id"
    }
}

// MARK: - UserDetails
struct UserDetails: Codable {
    let countryID: Int?
   // let dob: JSONNull?
    let firstName: String?
    let id: Int?
    let lastName, occupation, email, image: String?
    let gender: Int?
   // let address: [JSONAny]
    let age: Int?
    let phone, country: String?

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
      //  case dob
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case occupation, email, image
     //   case address
        case gender, age, phone, country
    }
}

