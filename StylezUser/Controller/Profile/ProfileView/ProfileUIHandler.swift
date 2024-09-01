//
//  ProfileUIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import UIKit

//MARK: - handling ui
extension ProfileViewController{
    
    func setGenderDetails(){
        if checkIfNotMale() == true{
            lblGender.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "female", comment: "")}
        else{
            lblGender.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "male", comment: "")}
    }
    
    func setLanguageLabel(){
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            lblLanguage.text = "العربية"
        }else{
            lblLanguage.text = "English"
        }
    }
    
    func setProfileViewImages(){
        for i in 0...imgTypes.count - 1 {
            if checkIfNotMale() == true{
                imgTypes[i].image = UIImage(named: "profile_female_\(i)")
            }else{
                imgTypes[i].image = UIImage(named: "profile_male_\(i)")
            }
        }
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            if checkIfNotMale() == true{
                imgTypes[6].image = UIImage(named: "profile_female_7")
            }else{
                imgTypes[6].image = UIImage(named: "profile_male_7")
            }
        }
        
        for all in imgArrow{
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                all.image = UIImage(systemName: "chevron.left")
            }else{
                all.image = UIImage(systemName: "chevron.right")
            }
        }
       
        //subscription
         imgSubscription.tintColor = getThemeColor()
    }
    
    func setLanguage(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile", comment: "")
        lblAccountHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "my_account", comment: "")
        lblSettingsHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "settings", comment: "")
        lblProfile.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile", comment: "")
        lblWallet.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "wallet", comment: "")
        lblAddress.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "address", comment: "")
        lblHistory.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "order_history", comment: "")
        lblNOtifications.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "notifications", comment: "")
        lblGenderHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "gender", comment: "")
        lblLanguageHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "language", comment: "")
        
        lblAccountDelete.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "DeleteAccount", comment: "")
  
    }
    
    func updateViewLoggedInOrOutState(){
        if getUserDetails() == nil{
            for all in viewLogin{
                all.isHidden = true
            }
            lblSignout.textColor = UIColor.systemGreen
            imgLogout.image = UIImage(named: "log_in")
            lblSignout.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sign_in", comment: "")
        }else{
            for all in viewLogin{
                all.isHidden = false
            }
            lblSignout.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sign_out", comment: "")
            lblSignout.textColor = UIColor.red
            imgLogout.image = UIImage(named: "log_out")
            lblPhone.text = "+966 \(getUserDetails()?["phone"] as? String ?? "")"
        }
    }
    
    
    //subscription
 
    func setUserPremimunView(){
        if K.User.isSubscribed {
            imgPremimum.isHidden = false
            lblSubscription.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.Subscription, comment: "")
            
        }
        else{
            imgPremimum.isHidden = true
            lblSubscription.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.upgradeTopRemium, comment: "")
            
        }
    }
    
    
}
