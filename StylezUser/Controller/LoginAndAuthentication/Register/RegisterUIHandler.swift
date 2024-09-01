//
//  UIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit

//MARK: - handling ui
extension RegisterViewController{
    
    func setThemeColor(){
        btnRegister.backgroundColor = getThemeColor()
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        imgCheck.tintColor = getThemeColor()
    }
   
    func handleTxtAlignment(){
        setTxtFieldALignment(tf: txtAge)
        setTxtFieldALignment(tf: txtName)
        setTxtFieldALignment(tf: txtEmail)
        setTxtFieldALignment(tf: txtPhone)
        setTxtFieldALignment(tf: txtPassword)
        setTxtFieldALignment(tf: txtOcupation)
        setTxtFieldALignment(tf: txtNationality)
    }
    
    func setAsterist(text : String) -> NSMutableAttributedString{
        let text = "\(text) *"
        let range = (text as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        
        //Apply to the label
        return  attributedString
    }
    
    func setLanguage(){
        btnClose.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "close", comment: ""), for: .normal)
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "create_account", comment: "")
        lblFullName.attributedText = setAsterist(text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "full_name", comment: ""))
        lblEmail.attributedText = setAsterist(text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: ""))
        lblPhone.attributedText = setAsterist(text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "phone", comment: ""))
      
        lblAge.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "age", comment: "")
        lblOccupation.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "occupation", comment: "")
        lblPassword.attributedText = setAsterist(text: LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: ""))
        
        
        lblNationality.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "nationality", comment: "")
       
        
        let string = LocalizationSystem.sharedInstance.localizedStringForKey(key: "agree_terms", comment: "")
        let range               = (string as NSString).range(of: LocalizationSystem.sharedInstance.localizedStringForKey(key: "policy", comment: ""))
        
        let attributedString    = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.black, range: range)
        
        lblAgree.attributedText = attributedString
        
        
        // lblAgree.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "agree_terms", comment: "")
        
        btnCreate.setTitle( LocalizationSystem.sharedInstance.localizedStringForKey(key: "create_account", comment: ""), for: .normal)
    }
    
    
    
}

