////
////  CountryResponseModel.swift
////  StylezUser
////
////  Created by MACBOOK on 2/21/24.
////
//
//import Foundation
//
//// MARK: - Welcome
//struct CountryResponseModel: Codable {
//    let status: Bool?
//    let messageAr, message: String?
//    let data: [CountryDatum]?
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case messageAr = "message_ar"
//        case message, data
//    }
//}
//
//// MARK: - Datum
//struct CountryDatum: Codable {
//    let phonecode, iso: String?
//    let id: Int?
//    let nicename, name: String?
//}


// MARK: - Welcome
struct CountryResponseModel: Codable {
    let countries: [Countrys]
}

// MARK: - Country
struct Countrys: Codable {
    let id: Int?
    let name, countryCode, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryCode = "country_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
