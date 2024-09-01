//
//  LoginViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 14/08/23.
//

import UIKit
import StylesWebKit
import FirebaseMessaging

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var btnQuick: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnLogin2: UIButton!
    @IBOutlet weak var imgLogo2: UIImageView!
    @IBOutlet weak var btnQuick2: UIButton!
    @IBOutlet weak var viewQuick: UIView!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var btnRetrive: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var lblPhone2: UILabel!
    @IBOutlet weak var btnCreate2: UIButton!
    
    var isFromProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setThemeColor()
        
        viewQuick.isHidden = true
       
        self.txtPhone.delegate = self
        
        localizeText()
    
        handleTextALignment()
        
        getDeviceToken()
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
   
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.register) as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)  
    }
    
    @IBAction func btnForgot(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.forgot) as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnQuick(_ sender: UIButton) {
        if viewQuick.isHidden == true{
            viewQuick.isHidden = false
            animationScaleEffectSingle(view: viewQuick)
        }else{
            viewQuick.isHidden = true
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if sender.tag == 0{
            loginUser2()
        }else{
            loginPhone2()
        }}
    
    @IBAction func btnEye(_ sender: UIButton) {
        updateSecureTFState(txtField: txtPassword, sender: sender)
    }
}

