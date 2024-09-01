//
//  OrderedHistory_Cell.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - not reordered order - HIstoryViewController

extension SalonListCell{
    
    func configOrders(){
        
        guard let order = order_notReorderd else {return}
        
        configCellUI()
        
        lblName.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? order.salon_name_ar : order.salon_name_en
        
        lblAddress.text = order.salon_address
        
        lblDate.text = getDateSting(date: order.start_time, time: order.start_time)
        
        handleAppointmentStaus(status: order.appointment_status,isSalonRated: order.salonRated)
        
        employeeName = order.employeeName ?? ""
        
        configServicesTableView(appointmnetServices: order.services)
        
        setPaidOrUnPaidLabel(paymentStatus: order.customer_prepaid)
        
        
        lblEmployeeHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Employee", comment: "")
        
        lblServiceHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Service", comment: "")
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.submitReview, comment: ""), attributes: underlineAttribute)
        
        rateYourOrderLabel.attributedText = underlineAttributedString
        rateYourOrderLabel.textColor = getThemeColor()
        
    }
    
    
    func getDateSting(date:String?, time:String?)-> String {
        
        let formattedDate = getFormatedDate2(dateString: date ?? "", requiredformat: K.DateFormats.dateLocale)
        
        let formattedTime = getFormatedDate2(dateString:time ?? "" , requiredformat: K.DateFormats.timeLocale)
        
        return "\(formattedDate) - \(formattedTime)"
    }
    
    
    func  configCellUI(){
        viewBg.layer.cornerRadius = 20
        viewBg.layer.masksToBounds = true
        viewBg.dropShadow(color: UIColor.lightGray)
    }
    
    func configServicesTableView(appointmnetServices:[AppointmentService]){
        services = appointmnetServices
        tblService.reloadData()
        //      tblHeight.constant = CGFloat(appointmnetServices.count * 30)
        tblHeight.constant = CGFloat(40)
    }
    
    func setPaidOrUnPaidLabel(paymentStatus:Int?){
        if paymentStatus == 1{
            lblPaid.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "paid", comment: "")
            viewPaid[0].backgroundColor = UIColor.systemGreen
            viewPaid[1].backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            lblPaid.textColor = UIColor.systemGreen
        }else{
            lblPaid.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "un_paid", comment: "")
            viewPaid[0].backgroundColor = UIColor.red
            lblPaid.textColor = UIColor.red
            viewPaid[1].backgroundColor = UIColor.red.withAlphaComponent(0.2)
        }
    }
    
    func handleAppointmentStaus(status:Int?, isSalonRated:Bool?){
        
        rateYourORderBtnHeight.constant = 0
        ratingView.isHidden = true
        
        switch status {
        case 1:
            lblStatus.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "active", comment: "")
            
            viewStatus[0].backgroundColor = UIColor.systemGreen
            viewStatus[1].backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
            
            lblStatus.textColor = UIColor.systemGreen
            
        case 2:
            lblStatus.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancelled", comment: "")
            
            viewStatus[0].backgroundColor = UIColor.red
            viewStatus[1].backgroundColor = UIColor.red.withAlphaComponent(0.3)
            
            lblStatus.textColor = UIColor.red
            
        case 3:
            lblStatus.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "attanded", comment: "")
            viewStatus[0].backgroundColor = UIColor(hexString: "FFBB00")
            viewStatus[1].backgroundColor = UIColor.init(hexString: "FCF2D0")
            
            lblStatus.textColor =  UIColor(hexString: "FFBB00")
           
            if isSalonRated == false
            {
                ratingView.isHidden = false
                rateYourORderBtnHeight.constant = 25
            }
            
        case 4:
            lblStatus.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "resceduled", comment: "")
            
            viewStatus[0].backgroundColor = UIColor.systemGreen
            viewStatus[1].backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
            
            lblStatus.textColor = UIColor.systemGreen
            
        default:
            lblStatus.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "active", comment: "")
            viewStatus[0].backgroundColor = UIColor.blue
            viewStatus[1].backgroundColor = UIColor.blue.withAlphaComponent(0.3)
            
            lblStatus.textColor = UIColor.blue
        }
    }
}

extension String {
    
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
}
