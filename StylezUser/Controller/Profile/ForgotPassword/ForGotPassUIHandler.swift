//
//  UIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit

//MARK: - handling UI
extension ForgotPasswordViewController{
    
    func setTextfieldAccordingToSelectedView(tag:Int){
        if tag == 0{
         self.isEmail = true
            txtEmail.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: "")
            txtEmail.keyboardType = .emailAddress
            animationScaleEffectSingle(view: txtEmail)
        }else{
            self.isEmail = false
            txtEmail.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: "")
            txtEmail.keyboardType = .numberPad
            animationScaleEffectSingle(view: txtEmail)
        }
    }
    
    func setLanguage(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "forgot_pass", comment: "")
        btnTypes[0].setTitle(" \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: ""))", for: .normal)
        btnTypes[1].setTitle(" \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "phone", comment: ""))", for: .normal)
        btnSubmit.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "submit", comment: ""), for: .normal)
      
        txtEmail.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: "")
        
        
        lblDescription.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.fogotPAssMsg, comment: "")
    }
    
    func configUI(){
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
       
        btnSubmit.backgroundColor = getThemeColor()
        viewBorder.layer.cornerRadius = 10
        viewBorder.layer.masksToBounds = true
        viewBorder.layer.borderWidth = 1
        viewBorder.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        viewBorder.dropShadow(color: UIColor.lightGray)}
    
    
    func updateBtnState(tag:Int){
       
        for i in 0...btnTypes.count-1{
            if i == tag{
                btnTypes[i].backgroundColor = getThemeColor()
                btnTypes[i].setTitleColor(UIColor.white, for: .normal)
                btnTypes[i].imageView?.tintColor = UIColor.black
            }
            else{
                btnTypes[i].backgroundColor = UIColor.clear
                btnTypes[i].setTitleColor(UIColor.darkGray, for: .normal)
                btnTypes[i].imageView?.tintColor = UIColor.darkGray
            }
        }
    }
}



//MARK: - handling textfield
extension ForgotPasswordViewController:UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        if isEmail == false{
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
                return  prospectiveText.count <= 9
        }else{
            return true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

