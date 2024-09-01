//
//  UIHandler_services.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit

extension ServiceDetailsViewController{
    
    
    func setupUI(){
        
        configViewCornersAndThemeColor()
        
        if isEmployee  == true{
            setUIForEmployeeDetails()
        }else{
            setUIForServiceDetails()
        }
    }
    
    
    
    func configViewCornersAndThemeColor(){
        viewTop.clipsToBounds = true
        viewTop.layer.cornerRadius = 25
        viewTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        
        viewBtn.backgroundColor = getThemeColor()
    }
    
}

//MARK: - employee
extension ServiceDetailsViewController{
    
    func ResetViewAndlocalizeLabels(){
        lblAmount.text = ""
        lblPriceHad.text = ""
        lblDurationHead.text = ""
        lblAmount.text = ""
        lblDes.text = ""
        
        lblNAme.text =  selectedEmployee?.first_name
        
        lblDuration.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? selectedEmployee?.branchNameAr : selectedEmployee?.branchNameEn
        
        lblEmployee.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "services", comment: "")
        
    }
    
    func setUIForEmployeeDetails(){
        
        ResetViewAndlocalizeLabels()
        
        self.desHeight.constant = 0
        
        setImage(imageView: imgUser, url: selectedEmployee?.image ?? "")
        
        imgUser.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        lblPrice.attributedText = getAttribuedString()
        
    }
    
    
    func getAttribuedString() -> NSMutableAttributedString{
        
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
      
        let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
        //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
        let attributedString4 = NSMutableAttributedString(string:"\("0.0") \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: ""))", attributes:attrs4 as [NSAttributedString.Key : Any])
        attributedString3.append(attributedString4)
        
        return attributedString3
    }
    
}

//MARK: - service details
extension ServiceDetailsViewController{
    
    func localizeServiceLabels(){
        lblNAme.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? selectedService?.name_ar : selectedService?.name_en
        
        lblPriceHad.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "rate", comment: "")
        
        lblAmount.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(selectedService?.amount ?? "")"
        lblEmployee.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "employee", comment: "")
        
        lblPrice.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_now", comment: "")
        
        lblDurationHead.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "duration", comment: "")): "
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            lblDuration.text = "\(selectedService?.duration ?? "") دقيقة"
        }else{
            lblDuration.text = "\(selectedService?.duration ?? "") Mins"
        }
        
        lblDes.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? selectedService?.description_ar : selectedService?.description_en
    }
    
  
    func setUIForServiceDetails(){
        
        localizeServiceLabels()
        
        imgUser.backgroundColor = UIColor.clear
        imgUser.image = UIImage(named: "test_5")
        
        self.desHeight.constant = self.lblDes.getSize(constrainedWidth:self.view.frame.width).height + 15
        
        //print("des height \(self.lblDes.getSize(constrainedWidth: self.view.frame.width).height)")
    }
    
}
