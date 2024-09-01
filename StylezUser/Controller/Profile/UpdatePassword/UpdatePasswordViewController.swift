//
//  UpdatePasswordViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 24/09/23.
//

import UIKit
import StylesWebKit

class UpdatePasswordViewController: BaseViewController {
    
    @IBOutlet var viewBorder: [UIView]!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirm: UITextField!
    @IBOutlet var txtOldPass: UITextField!
    @IBOutlet var viewOld: UIView!
    @IBOutlet var lblHead: UILabel!
  
    
    
    
    
    
    var otp = ""
    var userID = 0
    var isChangePassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setLanguage()
        handleTxtField()
        
        isChangePassword ? (self.viewOld.isHidden = false) : (self.viewOld.isHidden = true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        moveBack()
    }
    
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        isChangePassword ? changePassword2() : updatePassword2()
    }
    
    
    @IBAction func btnEye(_ sender: UIButton) {
        if sender.tag == 0{
            updateSecureTFState(txtField: txtOldPass, sender: sender)
        }
        else if sender.tag == 1{
            updateSecureTFState(txtField: txtPassword, sender: sender)
        }
        else{
            updateSecureTFState(txtField: txtConfirm, sender: sender)
        }
    }
    
}

//MARK: - navgation
extension  UpdatePasswordViewController{
    
    func moveBack(){
        if isChangePassword {
            self.navigationController?.popViewController(animated: true)
        }
        else{
            self.moveToLogin(delay: 0)
        }
    }
    
    func moveToLogin(delay:Double){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            var count = 1 // for checking purpose
            for aViewController in viewControllers {
                //print("count: \(count), -> \(aViewController)")
                count += 1
                if aViewController is LoginViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }
    }
}
