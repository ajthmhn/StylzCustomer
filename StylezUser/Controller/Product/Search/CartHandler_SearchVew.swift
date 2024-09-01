//
//  CartHandler_SearchVew.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit


extension SearchViewController{
    
    func configCartView(){
      
        if getCartData()?.count ?? 0 > 0{
           
            viewCart.isHidden = false
            viewCart.backgroundColor = getThemeColor()
            bottomSpace.constant = 80
            bottomSpaceEmployee.constant = 80
            lblCount.text = "\(getCartData()?.count ?? 0)"
            lblCount.layer.cornerRadius = 5
            lblCount.layer.masksToBounds = true
            lblCount.clipsToBounds = true
            
            var totals = [Double]()
            
            if let cartData = getCartData(){
                for all in cartData{
                    totals.append(Double(all["price"] as? String ?? "0.0")!)
                }
            }
            
            let sum = totals.reduce(0, +)
           
            let vat = (15 * sum) / 100
            
            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
            let attributedString4 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
            attributedString3.append(attributedString4)
            lblPrice.attributedText = attributedString3
            
            
        }else{
            viewCart.isHidden = true
            bottomSpace.constant = 0
            bottomSpaceEmployee.constant = 0
        }
    
    }
}
