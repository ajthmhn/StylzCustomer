//
//  URLExtension.swift
//  StylezUser
//
//  Created by abcd on 20/05/2024.
//

import Foundation

// Extension to extract query parameters from URL
extension URL {
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return nil
        }
        var parameters = [String: String]()
        for queryItem in queryItems {
            parameters[queryItem.name] = queryItem.value
        }
        return parameters
    }
}
