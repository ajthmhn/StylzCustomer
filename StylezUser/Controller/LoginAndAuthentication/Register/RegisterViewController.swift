//
//  RegisterViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 14/08/23.
//

import UIKit
import StylesWebKit
import WebKit

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtNationality: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtOcupation: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblHead: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblAgree: UILabel!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var viewPolicy: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnClose: UIButton!
    
    var isAccept = false
    var countryId = -1
    var countries = [Countrys]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountry2()
        
        txtPhone.delegate = self
        txtAge.delegate = self
        viewPolicy.isHidden = true
      
        setThemeColor()
        setLanguage()
        handleTxtAlignment()
        
        // txtNationality.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.getDeviceToken()
     }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnCountry(_ sender: UIButton) {
        configCountryDown(sender: sender)
    }
    
    
    @IBAction func btnAccept(_ sender: Any) {
        if isAccept == true{
            isAccept = false
            imgCheck.image = UIImage(systemName: "circle")
        }else{
            isAccept = true
            imgCheck.image = UIImage(systemName: "checkmark.circle.fill")
        }
    }
    
    
    @IBAction func btnPrivacy(_ sender: UIButton) {
        if sender.tag == 0{
            viewPolicy.isHidden = false
            animationScaleEffectSingle(view: webView)
            let link = URL(string:"https://stylz.me/terms-and-condition.html")!
            let request = URLRequest(url: link)
            webView.load(request)
        }else{
            viewPolicy.isHidden = true
        }
    }
    
    
    @IBAction func btnRegister(_ sender: Any) {
        registerUser2()
    }
    
    @IBAction func btnEye(_ sender: UIButton) {
       updateSecureTFState(txtField: txtPassword, sender: sender)
    }
    
}
