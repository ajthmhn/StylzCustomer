//
//  UIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/26/24.
//

import Foundation
import UIKit

//MARK: - handling ui
extension LoginViewController{
    
    func handleTextALignment(){
        setTxtFieldALignment(tf: txtEmail)
        setTxtFieldALignment(tf: txtPhone)
        setTxtFieldALignment(tf: txtPassword)
    }
    
    func localizeText(){
        lblLogin.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "login", comment: "")
        lblEmail.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: "")
        lblPassword.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: "")
        btnRetrive.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "retrive_passwrd", comment: ""), for: .normal)
        btnLogin.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "login", comment: ""), for: .normal)
        btnLogin2.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "login", comment: ""), for: .normal)
        btnCreate.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "create_account", comment: ""), for: .normal)
        btnCreate2.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "create_account", comment: ""), for: .normal)
        btnQuick.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "quick_login", comment: ""), for: .normal)
        btnQuick2.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "email_login", comment: ""), for: .normal)
        lblPhone2.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "phone", comment: "")
    }
    
    func setThemeColor(){
        btnQuick2.setTitleColor(getThemeColor(), for: .normal)
        btnQuick.setTitleColor(getThemeColor(), for: .normal)
        btnLogin.backgroundColor = getThemeColor()
        btnPassword.setTitleColor(getThemeColor(), for: .normal)
        btnBack.tintColor = getThemeColor()
        imgLogo.tintColor = getThemeColor()
        imgLogo2.tintColor = getThemeColor()
        btnLogin2.backgroundColor = getThemeColor()
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
    }
}




