//
//  OTPViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 22/08/23.
//

import UIKit
import AEOTPTextField
import StylesWebKit
import FirebaseMessaging

class OTPViewController: BaseViewController {
    
    @IBOutlet var txtOtp: AEOTPTextField!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblHead2: UILabel!
    @IBOutlet var btnContinue: UIButton!
    @IBOutlet var lblReceive: UILabel!
    @IBOutlet var btnResend: UIButton!
    
    @IBOutlet var backBtn: UIButton!
        
    var otp = ""
    var mobile = ""
    var otpRight = ""
    var userId = 0
    var isPhoneLogin = false
    var isEmail = false
    var isPassword = false
    //  var deviceToken = ""
    var isUpdate = false
  
    var numOrEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configOTPTextField()
        setLanguage()
        backBtn.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        self.getDeviceToken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
                DispatchQueue.main.async {
                    showAlert(title: self.otp, subTitle: "For testing use this otp", sender: self)
                }
    }
    
    @IBAction func btnVerify(_ sender: Any) {
        if isPassword == true{
            doUpdatePassword()
        }
        else if isPhoneLogin == true{
            verifyOtp2()
        }else{
            verifyLoginOtp2()
        }
    }
    
    @IBAction func btnResend(_ sender: Any) {
        txtOtp.clearOTP()
        self.otpRight = ""
        
        if isPassword == true{
            forgotPassword2()
        }
        else if isPhoneLogin == true{
//            resendOtp2()
            resendLoginOtp2()
        }else{
            resendLoginOtp2()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func doUpdatePassword(){
        if self.otp != self.otpRight{
            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "valid_otp", comment: ""), sender: self)
            return
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.updatePass) as! UpdatePasswordViewController
            vc.userID = self.userId
            vc.otp = self.otpRight
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension OTPViewController: AEOTPTextFieldDelegate,UITextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        //print(code)
        otpRight = code
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        otpRight = textField.text ?? ""
        
        //print("textfield did change: \(textField.text?.count), otp \(otpRight)")
    }
}



