//
//  SearchCel.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit


//MARK:  - search view controller
extension ServiceListCell{
    
    func configSearchedServiceCell(){
        
        guard let service = searchedService else{return}
        
        configSearchedServcieUI()
        
        lblPrice.attributedText = getAttributedString(amount: service.amount ?? "")
       
        lblName.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? service.name_ar : service.name_en
       
        lblDuration.text = service.duration
        
        imgProduct.image = UIImage(named: "test_5")
        
        branchName.isHidden = false
        branchName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? service.branchNameAr : service.branchNameEn
      
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            lblDuration.text = "\(service.duration ?? "") دقيقة"
        }else{
            lblDuration.text = "\(service.duration ?? "") Mins"
        }
        
        lblRateHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "rate", comment: "")
        
        lblDurationHead.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "duration", comment: "")): "
       
        
    }
    
    func configSearchedServcieUI(){
        dropShadow(color: UIColor.lightGray)
    }
    
    func getAttributedString(amount:String) -> NSMutableAttributedString{
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 14.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 18.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) ", attributes:attrs3 as [NSAttributedString.Key : Any])
        //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
        let attributedString4 = NSMutableAttributedString(string:"\(amount)", attributes:attrs4 as [NSAttributedString.Key : Any])
        
        attributedString3.append(attributedString4)
        
        return attributedString3
    }
    
}



