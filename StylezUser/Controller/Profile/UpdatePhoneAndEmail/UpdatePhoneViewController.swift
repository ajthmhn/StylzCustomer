//
//  UpdatePhoneViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 16/09/23.
//

import UIKit
import StylesWebKit

class UpdatePhoneViewController: BaseViewController {
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var lblHead: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnUPdate: UIButton!
   
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet var lblSubheading: UILabel!
    @IBOutlet var lblEmailORNum: UILabel!
  
    @IBOutlet var emailView: UIView!
    @IBOutlet var numberView: UIView!
    
    var isPhone = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizaTextFields()
        setTxtFieldALignment(tf: txtPhone)
        localizeBtnTextAndSetThemeColor()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
      isPhone == true ? updatePhone2() : updateEmail2()
    }
}


//MARK: - Handling UI
extension UpdatePhoneViewController{
    func localizeBtnTextAndSetThemeColor(){
        
        btnUPdate.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "update", comment: ""), for: .normal)
        
        btnUPdate.backgroundColor = getThemeColor()
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        lblEmailORNum.textColor = getThemeColor()
    }
    
    func localizaTextFields(){
        if isPhone == true{
            txtPhone.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: "")
            //lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "update_phone", comment: "")
           
            
            lblHeading.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.updateYourNumber, comment: "")
            lblSubheading.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.updateYourNumberSubHead, comment: "")
            lblEmailORNum.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.phone, comment: "")
            
            self.txtPhone.delegate = self
            self.txtPhone.keyboardType = .phonePad

            self.numberView.isHidden = false

        }else{
            self.txtPhone.delegate = nil
          
            lblHeading.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.updateYourEmail, comment: "")
            lblSubheading.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.updateYourEmailSubHead, comment: "")
            lblEmailORNum.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.email, comment: "")
            
            
            txtPhone.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: "")
         
         //   lblHead.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "update_email", comment: "")
            
            self.numberView.isHidden = true

            self.txtPhone.keyboardType = .emailAddress
        }
    }
}


//MARK: - textfield delegate
extension UpdatePhoneViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
       
        switch textField {
        
        case txtPhone :
            return prospectiveText.containsOnlyCharactersIn(matchCharacters: "0123456789") &&
            prospectiveText.count <= 9
       
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

