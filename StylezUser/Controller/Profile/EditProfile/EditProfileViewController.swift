//
//  EditProfileViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 20/08/23.
//

import UIKit
import StylesWebKit
import DropDown

class EditProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var viewBg: [UIView]!
    @IBOutlet var imgIcons: [UIImageView]!
    @IBOutlet var editableViews: [UIView]!
    
    @IBOutlet var viewBase: UIView!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtCountry: UITextField!
    @IBOutlet var txtAge: UITextField!
    @IBOutlet var txtJob: UITextField!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var btnUpdate: UIButton!
    @IBOutlet var viewUpload: UIView!
    @IBOutlet var txtPAssword: UITextField!
    @IBOutlet var imgUser: UIImageView!
    
    @IBOutlet var BtnEmailVerification: UIButton!
    @IBOutlet var BtnPhoneVerification: UIButton!
   
    @IBOutlet var BtnEdit: UIButton!
    @IBOutlet var lblUpload: UILabel!
   
    
    @IBOutlet var backBtn: UIButton!
   
    //@IBOutlet var  viewImageUpload: UIView!
   
    
    var imagePicker = UIImagePickerController()
    var imageSelected = false
    
    var countryId = 0
    var countries = [Countrys]()
     var _isEditing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeFieldState(isEnabled: false)
        setThemeColorAndBorders()
        btnUpdate.backgroundColor = getThemeColor()
        backBtn.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        localizeAllText()
        setTextfieldAlignment()
        
        getDeviceToken()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCustomerInfo()
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        doUpdateProfile()
    }
    
    @IBAction func onClick_EmailVerificationbtn(_ sender: UIButton) {
        moveToVerificationViewIfEmailNotVerified()
    }
    
    @IBAction func onClick_PhoneVerificationBtn(_ sender: UIButton) {
        moveToVerificationViewIfNumberNotVerified()
        
    }
    
    @IBAction func onClick_EditBtn(_ sender: UIButton) {
       doEnableFieldsForEditing()
    }
   
    @IBAction func btnPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.updatePass) as! UpdatePasswordViewController
        vc.isChangePassword = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.updatePhone) as! UpdatePhoneViewController
        sender.tag == 0 ? (vc.isPhone = true) : (vc.isPhone = false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSelectImage(_ sender: UIButton) {
        self.presentImagePicker()}
}



//MARK: - update/edit btn handler
extension EditProfileViewController{
    
    func doUpdateProfile(){
    //animationScaleEffect(view: editableViews)
      changeFieldState(isEnabled: false)
        _isEditing = false
        updateProfile2()
    }
    
    func doEnableFieldsForEditing(){
        changeFieldState(isEnabled: true )
        _isEditing = true
        animationScaleEffect(view: editableViews)
    }
}



//MARK: - navigation
extension EditProfileViewController{
    
    
    func moveToVerificationViewIfEmailNotVerified(){
        if getUserDetails()?["email_verified"] as? Bool == false{
            let id = StylzAPIFacade.shared.session?.UserId ?? -1
            self.sendOtpLogin(phone: "", email: txtEmail.text ?? "", id: id, isEmail: true)
        }
    }
    
    func moveToVerificationViewIfNumberNotVerified(){
        if getUserDetails()?["phone_verified"] as? Bool == false{
            
            let id = StylzAPIFacade.shared.session?.UserId ?? -1
            //print("user id \(id)")
          
            self.sendOtpLogin(phone: txtPhone.text ?? "", email:  "", id: id , isEmail: false)
        } 
    }
    
}
