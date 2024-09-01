//
//  NotificationsCell.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit


//MARK: - notifications
extension ServiceListCell{
    
    func configUI(){
        self.dropShadow(color: UIColor.lightGray)
        self.viewBg.dropShadow(color: UIColor.lightGray)
        self.viewBg.layer.cornerRadius = 20
        self.viewBg.layer.masksToBounds = true
    }
    
    func configNotification(){
        guard let notification else {return}
        
        configUI()
      //  setDateColor()
        
        lblName.text =  "\(notification.title ?? "")\n\n\(notification.message ?? "")"
        
        if let createdAT = notification.created_at{
          //print("setting date")
            setDate(createdAt: createdAT)
        }
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.submitReview, comment: ""), attributes: underlineAttribute)
        
        
        if let appointment = notification.appointment, appointment.appointment_status == 3, appointment.salonRated == false
        {
         //print("appointmennt status is 3")
            ratingView.isHidden = false
            rateYourORderBtnHeight.constant = 25
        }
        else{
            ratingView.isHidden = true
            rateYourORderBtnHeight.constant = 0
        
        }
       
        rateYourOrderLabel.attributedText = underlineAttributedString
        rateYourOrderLabel.textColor = getThemeColor()
        
    }
    
    func setDate(createdAt:String){
        let dateFor = DateFormatter()
        dateFor.locale = Locale(identifier:"UTC")
       // dateFor.dateFormat = "d/MMM/yyyy h:mm a"
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
         
        let date = dateFor.date(from: createdAt)
       
         //print()
        
        if let date {
            dateFor.dateFormat = "MMM d"
          
            let dates =  dateFor.string(from: date)
            lblDuration.text = dates.replacingOccurrences(of: " ", with: "\n")
            
            dateFor.dateFormat = "h:mm a"
            lblPrice.text =  dateFor.string(from: date)
            
        }
        
        
        
//        let formattedDate = getFormatedDate2(dateString: createdAt, requiredformat: "MMM d")
//        lblDuration.text = formattedDate.replacingOccurrences(of: " ", with: "\n")
//   
//        let formattedTime = getFormatedDate2(dateString:createdAt, requiredformat: "h:mm a")
//        lblPrice.text =  formattedTime
//   
        
    }
    
    func setDateColor(){
        if index % 2 == 0{
            //print("indexpath.row % 2 == 0")
            viewNot.backgroundColor = UIColor(hexString: "61AB9A")?.withAlphaComponent(0.1)
            lblDuration.textColor = UIColor(hexString: "61AB9A")
        }else{
            //print("indexpath.row % 2 != 0")
            
            viewNot.backgroundColor = UIColor(hexString: "168BCC")?.withAlphaComponent(0.1)
            lblDuration.textColor = UIColor(hexString: "168BCC")
        }
    }
}


