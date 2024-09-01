//
//  ServiceViiewCell.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit

//MARK: - ServiceViewController - offer cell

extension ServiceListCell{
    
    func configOfferCell(){
        
        guard let offerObj = offerObj else {return}
        
        dropShadow(color: UIColor.lightGray)
        
        lblName.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? offerObj.name_ar : offerObj.name_en
        
        lblDuration.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? offerObj.description_ar : offerObj.description_en
        
        lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(offerObj.discount_value ?? 0.0)"
        
        lblService.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.couponCode, comment: "")):  \(offerObj.discount_coupon ?? "")"
        
    }
}

