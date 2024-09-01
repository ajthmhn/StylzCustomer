//
//  EditProfileUIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import UIKit


//MARK: - set initial view
extension EditProfileViewController{
    
    func changeFieldState(isEnabled:Bool){
        txtName.isEnabled = isEnabled
        txtAge.isEnabled = isEnabled
        txtJob.isEnabled = isEnabled
    
     //   viewImageUpload.isHidden = !isEnabled
      
        BtnEdit.isHidden = isEnabled
        btnUpdate.isHidden =  !isEnabled
    }
}

//MARK: - update UI
extension EditProfileViewController{
    
    func setThemeColorAndBorders(){
        for all in imgIcons{
            all.tintColor = getThemeColor()
        }
        
        viewUpload.layer.cornerRadius = 15
        viewUpload.layer.masksToBounds = true
        viewUpload.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        viewUpload.layer.borderWidth = 1
    }
    
    
    func setTextfieldAlignment(){
        setTxtFieldALignment(tf:txtName)
        setTxtFieldALignment(tf:txtPhone)
        setTxtFieldALignment(tf:txtEmail)
        setTxtFieldALignment(tf:txtCountry)
        setTxtFieldALignment(tf:txtAge)
        setTxtFieldALignment(tf:txtJob)
        setTxtFieldALignment(tf:txtPAssword)
    }
    
    
    func localizeAllText(){
        btnUpdate.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "update_profile", comment: ""), for: .normal)
       
        lblUpload.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.Upload, comment: "")
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile", comment: "")
        
        txtName.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "name", comment: "")
        
        txtCountry.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "nationality", comment: "")
        txtAge.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "age", comment: "")
        txtJob.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "occupation", comment: "")
        txtPAssword.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "change_password", comment: "")
    }
    
   
}



//MARK: - populate user data
extension EditProfileViewController{
   
    
    func populateUserDetials(){
    
        self.countryId = getUserDetails()?["country_id"] as? Int ?? 1
       
        txtName.text = getUserDetails()?["first_name"] as? String ?? ""
        txtEmail.text = getUserDetails()?["email"] as? String ?? ""
        txtPhone.text = getUserDetails()?["phone"] as? String ?? ""
        txtCountry.text = getUserDetails()?["country_name"] as? String ?? ""
        
        txtJob.text = getUserDetails()?["occupation"] as? String ?? ""
        txtAge.text = "\(getUserDetails()?["age"] as? Int ?? 0)"
      
        txtCountry.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
   
    func setUserImage(){
       
        //print("~ user image linnk \(getUserDetails()?["image"])")
        
        if getUserDetails()?["image"] as? String == "" || getUserDetails()?["image"] as? String == nil{
            imgUser.image = UIImage(named: "User-icon") //
        }
        else{
            //print("setting server image")
            setImage(imageView: imgUser, url: getUserDetails()?["image"] as? String ?? "")
        }
    }
}

//MARK: - verified and unverified btn
extension EditProfileViewController{
    
    
    func updateViewForVerifiedDetails(){
        updateEmailStatus()
        updatePhoneStatus()
    }
    
    func updatePhoneStatus(){
       
        if getUserDetails()?["phone_verified"] as? Bool == true{
            
        let status = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.verified, comment: "")
            
        BtnPhoneVerification.setTitle(status, for: .normal)
        setBtnColor(color: maleColor!, btn: BtnPhoneVerification)
        }
        else{
            let status = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.unVerified, comment: "")
                
            BtnPhoneVerification.setTitle(status, for: .normal)
            setBtnColor(color: femaleColor!
                        , btn: BtnPhoneVerification)
         }
     
    }

    func updateEmailStatus(){
      
        if getUserDetails()?["email_verified"] as? Bool == true{
            
        let status = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.verified, comment: "")
            
            
        BtnEmailVerification.setTitle(status, for: .normal)
        setBtnColor(color: maleColor!, btn: BtnEmailVerification)
            
        }
        else{
            let status = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.unVerified, comment: "")
                
            BtnEmailVerification.setTitle(status, for: .normal)
            setBtnColor(color: femaleColor!
                        , btn: BtnEmailVerification)
            
        }
    }

    func setBtnColor(color:UIColor, btn:UIButton){
        btn.backgroundColor = color.withAlphaComponent(0.2)
        btn.tintColor = color
    }
  
}
