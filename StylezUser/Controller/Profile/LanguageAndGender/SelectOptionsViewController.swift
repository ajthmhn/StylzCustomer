//
//  SelectOptionsViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 20/08/23.
//

import UIKit
import IQKeyboardManagerSwift

class SelectOptionsViewController: UIViewController {
    
    
    @IBOutlet var viewGender: [UIView]!
    @IBOutlet var viewLanguage: [UIView]!
    @IBOutlet var imgLanguage: [UIImageView]!
    @IBOutlet var imgGender: [UIImageView]!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblMale: UILabel!
    @IBOutlet var lblFemale: UILabel!
    
    @IBOutlet var viewGenderBase: [UIView]!
    @IBOutlet var viewLanguageBase: [UIView]!
    @IBOutlet var btnSelect: UIButton!
    
    var _languageChange = false
    var isGender = false
    var isFemale = false
    var selectedLanguageTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isFemale =  checkIfNotMale()
        
        localiseTextAndSetThemeColor()
        
        setViewForTheOptedCase()
        
        isGender ? configGenderView() : configLanguageView()
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnGender(_ sender: UIButton) {
        
        //    clearCart() // it should be called while updating the gender
      
        sender.tag == 0 ?
        (isFemale = false) : (isFemale = true)
       
        self.updateGenderView(tag: sender.tag)
    }
    
    @IBAction func btnLanguage(_ sender: UIButton) {
        self._languageChange = true
        self.selectedLanguageTag = sender.tag
        self.updateLanguageView(tag: sender.tag)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        
        //updating the default settings and theme color
        isNotMale(value: isFemale)
        
        isGender ? clearCart() : doUpdateLanguage()
        
        moveToMain()
    }
}

//MARK: - update btn
extension SelectOptionsViewController{
    
    func doUpdateLanguage(){
        if self._languageChange == true{
            if selectedLanguageTag == 0{
                LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
                IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "تم"
            }
            else{
                LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
                IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
            }
        }
        
        UIView.appearance().semanticContentAttribute =   LocalizationSystem.sharedInstance.getLanguage() == "ar" ? .forceRightToLeft : .forceLeftToRight
        
        languageChange = self._languageChange
    }
    
    func moveToMain(){
        let stry = UIStoryboard(name: "Main", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier: "root_vc")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}
