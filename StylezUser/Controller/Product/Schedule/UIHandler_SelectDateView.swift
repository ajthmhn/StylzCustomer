//
//  UIHandler_SelectDateView.swift
//  StylezUser
//
//  Created by mac on 18/03/2024.
//

import Foundation
import UIKit

extension SelectDateViewController{
    
    
    func setDateLabel(){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        dateFormat.locale  = Locale(identifier: "en")
        lblDate.text = dateFormat.string(from: Date())
    }
    
    func localizeView(){
        if isreOrder == true{
            btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "re_order", comment: ""), for: .normal)
        }else{
            if isRescedule == true{
                btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "rescedule_appoint", comment: ""), for: .normal)
            }else{
                btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "checkout", comment: ""), for: .normal)
            }
        }
        
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_date", comment: "")
        
        lblAvbailable.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "available_time", comment: "")
        
        btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "checkout", comment: ""), for: .normal)
        
    }
}
