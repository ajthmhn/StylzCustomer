//
//  DoubleExtension.swift
//  StylezUser
//
//  Created by abcd on 18/04/2024.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
