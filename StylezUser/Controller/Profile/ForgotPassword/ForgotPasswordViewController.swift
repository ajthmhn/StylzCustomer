//
//  ForgotPasswordViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 24/09/23.
//

import UIKit
import StylesWebKit

class ForgotPasswordViewController: BaseViewController {
    
    @IBOutlet var btnTypes: [UIButton]!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var viewBorder: UIView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblDescription: UILabel!

    var isEmail = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
        self.txtEmail.delegate = self
        
        updateBtnState(tag: 0)
        setLanguage()
        setTxtFieldALignment(tf: txtEmail)
    }
   
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.forgotPassword2()
    }

    
@IBAction func btnTypes(_ sender: UIButton) {
    txtEmail.text = ""
    txtEmail.resignFirstResponder()
    updateBtnState(tag: sender.tag)
    setTextfieldAccordingToSelectedView(tag: sender.tag)
}

    
}

