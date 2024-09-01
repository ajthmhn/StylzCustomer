//
//  StringExtension.swift
//  StylezUser
//
//  Created by MACBOOK on 2/20/24.
//

import Foundation

extension String {
    func validateEmail() -> Bool{
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
    }
    
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {

        if(self.isEmpty) {
            return true
        }

        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            // string contains non-whitespace characters
        }
}
