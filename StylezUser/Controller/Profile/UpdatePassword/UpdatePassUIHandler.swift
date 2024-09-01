//
//  UpdatePassUIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import Foundation
import UIKit

//MARK: - handling ui
extension UpdatePasswordViewController{

    func configUI(){
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        btnSubmit.backgroundColor = getThemeColor()
        for all in viewBorder{
            all.layer.cornerRadius = 10
            all.layer.masksToBounds = true
            all.layer.borderWidth = 1
            all.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            all.dropShadow(color: UIColor.lightGray)}
    }
    
    func setLanguage(){
        if isChangePassword == true{
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "change_password", comment: "")}
        else{
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "update_pass", comment: "")}
        
        txtPassword.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "new_password", comment: "")
        txtConfirm.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirm_password", comment: "")
        txtOldPass.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "old_password", comment: "")
        
        btnSubmit.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "update", comment: ""), for: .normal)
    }
    
    func handleTxtField(){
        setTxtFieldALignment(tf: txtPassword)
        setTxtFieldALignment(tf: txtConfirm)
        setTxtFieldALignment(tf: txtOldPass)
    }
}


