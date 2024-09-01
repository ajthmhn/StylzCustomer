//
//  OTPUIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit

//MARK: - handling ui
extension OTPViewController{
  
    func configOTPTextField(){
        txtOtp.otpDelegate = self
        txtOtp.otpFont = UIFont.boldSystemFont(ofSize: 22)
        txtOtp.otpFontSize = 22
        txtOtp.otpTextColor = UIColor.black
        txtOtp.otpCornerRaduis = 10
        txtOtp.otpDefaultBorderColor = UIColor.lightGray.withAlphaComponent(0.3)
        txtOtp.otpDefaultBorderWidth = 1
        txtOtp.otpBackgroundColor = UIColor(hexString: "FFFFFF")!
        txtOtp.otpFilledBorderColor = UIColor(hexString: "143659")!
        txtOtp.otpFilledBackgroundColor = UIColor(hexString: "FFFFFF")!
        
        txtOtp.configure(with: 5)
    
        txtOtp.textContentType = .oneTimeCode
        
        txtOtp.keyboardType = .numberPad
        txtOtp.becomeFirstResponder()
        txtOtp.textAlignment = .left
        
        txtOtp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
    }
    
    func setLanguage(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "otp_verification", comment: "")
        if isEmail == true{
            lblHead2.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "check_email", comment: "")
        }else{
            lblHead2.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "check_phone", comment: "")
        }
        
        btnContinue.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "continue", comment: ""), for: .normal)
        lblReceive.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "didnt_receive", comment: "")
        btnResend.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "resend", comment: ""), for: .normal)
        
        if isUpdate == true{
            btnResend.isHidden = true
            lblReceive.isHidden = true
        }else{
            btnResend.isHidden = false
            lblReceive.isHidden = false
        }
     
        
    }
}
