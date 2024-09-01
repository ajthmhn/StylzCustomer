//
//  EnableLocationViewController.swift
//  StylezUser
//
//  Created by abcd on 27/05/2024.
//

import UIKit

class EnableLocationViewController:  BaseViewController {

    @IBOutlet weak var imgLocation: UIImageView!
  
    @IBOutlet var lblShareLocation: UILabel!
    @IBOutlet var lblEnableLocation: UILabel!
    @IBOutlet var lblShareLocationMsg: UILabel!
    
    @IBOutlet var btnLocation: UIButton!
    
    @IBOutlet var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        localizeView()
        setThemeColor()
        setCornerRadius()
    }
    

    @IBAction func btnGotoSettigs(_ sender: UIButton) {
     goToLocationSettings()
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}

//MARK: -
extension EnableLocationViewController{

    func localizeView(){
        lblShareLocation.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.shareLocation, comment: "")
        lblEnableLocation.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.enableLocation, comment: "")
        lblShareLocationMsg.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.enableLocationMsg, comment: "")
        btnLocation.setTitle( LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.goToSettings, comment: ""), for: .normal)
    }
    
    func setThemeColor(){
        imgLocation.tintColor = getThemeColor()
        btnLocation.backgroundColor = getThemeColor()
    }
    
    func setCornerRadius(){
     //   mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 20
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
