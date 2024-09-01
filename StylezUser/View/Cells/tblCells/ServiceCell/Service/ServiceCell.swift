//
//  ServiceCell.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit

//MARK: - ServiceViewController - Service cell

extension ServiceListCell{
    
    func configServiceCell(){
        
        guard let service = service else { return }
        
        dropShadow(color: UIColor.lightGray)
        
        lblName.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? service.name_ar : service.name_en
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            lblDuration.text = "\(service.duration ?? "") دقيقة"
        }else{
            lblDuration.text = "\(service.duration ?? "") Mins"
        }
        
        lblRateHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "rate", comment: "")
        lblDurationHead.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "duration", comment: "")):"
        
        
        imgProduct.image = UIImage(named: "test_5")
        
        
        lblPrice.attributedText = getAttributesString(amount: service.amount ?? "")
        
        // setImage(imageView: imgProduct, url: categories[selectedService].service_category_icon ?? "")
    }
    
    func getAttributesString(amount:String) -> NSMutableAttributedString{
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 14.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 18.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) ", attributes:attrs3 as [NSAttributedString.Key : Any])
        
        let attributedString4 = NSMutableAttributedString(string:"\(amount)", attributes:attrs4 as [NSAttributedString.Key : Any])
        attributedString3.append(attributedString4)
        
        return attributedString3
    }
}
