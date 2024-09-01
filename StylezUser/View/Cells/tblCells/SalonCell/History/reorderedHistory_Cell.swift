//
//  reorderedHistory_Cell.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - reordered order  - HIstoryViewController
extension SalonListCell{
    
    func configReorderedOrders(){
        
        guard let order = order_Reorderd else {return}
        
        //print("~ in history config reorderd orders")
        updateReorderedCellUI()
        
        lblService.text =
        "\(getServicesName(services: order.services)) ****"
        
        lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? order.salon_name_ar : order.salon_name_en
    }
    
    func getServicesName(services:[AppointmentService]) -> String{
        
        var name = [String]()
        for all in services{
            name.append(LocalizationSystem.sharedInstance.getLanguage() == "ar" ? all.service_name_ar ?? "" : all.service_name_en ?? "")
        }
        return name.joined(separator: ",")
    }
    
    func updateReorderedCellUI(){
        
        viewBg.layer.cornerRadius = 20
        viewBg.layer.masksToBounds = true
        viewBg.layer.borderColor = UIColor.lightGray.cgColor
        viewBg.layer.borderWidth = 0.5
        viewBg.dropShadow(color: UIColor.lightGray)
        
    }
    
    //            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 9.0)!, NSAttributedString.Key.foregroundColor : getThemeColor()]
    //            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 14.0)!, NSAttributedString.Key.foregroundColor : getThemeColor()]
    //            let attributedString1 = NSMutableAttributedString(string:"SAR ", attributes:attrs1 as [NSAttributedString.Key : Any])
    //            let attributedString2 = NSMutableAttributedString(string:" \(orders[indexPath.item].service_amount ?? 0.0)", attributes:attrs2 as [NSAttributedString.Key : Any])
    //            attributedString1.append(attributedString2)
    //            cell.lblPaid.attributedText = attributedString1
    
    
}

