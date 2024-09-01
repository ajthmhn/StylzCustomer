//
//  HomeUIHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import Foundation
import UIKit
import ImageSlideshow
import StylesWebKit


//MARK: - Images and view configuration
extension HomeViewController{
    
    func setLocationViewBtn(){
        btnLocation.backgroundColor = getThemeColor()
        
        btnLocation.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "enable_location", comment: ""), for: .normal)
        
        viewLocation.isHidden = true
        
    }
    
    func updateAddressLabel(){
        if userAddress == ""{
            self.lbladdress.text = ""
        }else{
            self.lbladdress.text = userAddress
        }
    }
    
    func setBtNOTImage(){
        if checkIfNotMale() == true{
            btnNOt.setImage(UIImage(named: "profile_female_4"), for: .normal)
        }else{
            btnNOt.setImage(UIImage(named: "profile_male_4"), for: .normal)
        }
    }
    
    func setBannerImage(){
      
//        if checkIfNotMale() == true{
//            self.slider.setImageInputs([ImageSource(image: UIImage(named: "female_1")!),ImageSource(image: UIImage(named: "female_2")!)])
//        }else{
//            self.slider.setImageInputs([ImageSource(image: UIImage(named: "slider1")!),ImageSource(image: UIImage(named: "slider2")!),ImageSource(image: UIImage(named: "slider3")!)])
//        }
//        
        
         if checkIfNotMale() == true{ self.slider.setImageInputs([ImageSource(image: UIImage(named: "fbanner1")!),ImageSource(image: UIImage(named: "fbanner2")!),ImageSource(image: UIImage(named: "fbanner3")!)])
         }else{
             self.slider.setImageInputs([ImageSource(image: UIImage(named: "banner1")!),ImageSource(image: UIImage(named: "banner2")!),ImageSource(image: UIImage(named: "banner3")!)])
             
         }
         
    }
    
    func setupUI(){
        self.slider.slideshowInterval = 5.0
        self.slider.contentScaleMode = .scaleAspectFill
        self.slider.pageIndicator = nil
        self.slider.layer.cornerRadius = 20
        self.slider.layer.masksToBounds = true
        
        
        viewMenus.layer.masksToBounds = true
        viewMenus.layer.cornerRadius = 20
        viewMenus.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        viewSearch.layer.cornerRadius = 20
        viewSearch.layer.masksToBounds = true
        
        viewCategory[0].backgroundColor = getThemeColor()
        viewCategory[1].backgroundColor = UIColor.white
        viewCategory[1].layer.borderWidth = 1
        viewCategory[1].layer.borderColor = UIColor.black.cgColor
        
        viewSalons[0].backgroundColor = getDarkColor()
        viewSalons[1].backgroundColor = UIColor.white
        viewSalons[1].layer.borderWidth = 1
        viewSalons[1].layer.borderColor = UIColor.black.cgColor
    }
}



//MARK: - localization

extension HomeViewController{
    
    func localalizeNoDataLabel(){
        for all in lblNoData{
            all.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "no_data", comment: "")}
    }
    
    func localizeTab() {
        self.tabBarController?.tabBar.items![0].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "home", comment: "")
        self.tabBarController?.tabBar.items![1].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointment", comment: "")
        self.tabBarController?.tabBar.items![2].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile", comment: "")
        self.tabBarController?.tabBar.items![3].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cart", comment: "")
        
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            txtSearch.textAlignment = .right
        }else{
            txtSearch.textAlignment = .left
        }
        
        txtSearch.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search_hair", comment: "")
        btnCategory.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_category", comment: ""), for: .normal)
        btnStylist.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_stylist", comment: ""), for: .normal)
        lblSalons.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "my_salons", comment: "")
        
        for all in btnslow{
            all.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "show_all", comment: ""), for: .normal)
        }
        
        lblappoint.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointment", comment: "")
        lblReOrder.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "re_order", comment: "")
        lblTopSalons.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "top_saloons", comment: "")
        lblallBarber.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "all_barber", comment: "")
        
    }
    
    func localizeCategoryLabels(){
        lblScedules.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "schedules", comment: "")
        lblSaloons.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "my_salons", comment: "")
        lblStylist.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_stylist", comment: "")
        lblCategory.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_category", comment: "")
    }
    
   
    func configTF(){
        txtSearch.delegate = self
     //   txtSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
}

//MARK: - textfeild delegate  - search
extension  HomeViewController: UITextFieldDelegate{
   
    func moveToSearchView(){
        if txtSearch.hasText, txtSearch.text != "",((txtSearch.text?.isEmptyOrWhitespace()) == false){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.search) as! SearchViewController
            vc.keyWord = txtSearch.text ?? ""
            txtSearch.text = ""
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("return pressed")
        
        textField.resignFirstResponder()
     
        self.moveToSearchView()
        
        return true
    }
}



//MARK: - custom tab bar
class CustomTabBarVC: UITabBarController, UITabBarControllerDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tabBar.tintColor = getThemeColor()
        self.tabBar.barTintColor = .white
        self.tabBar.isTranslucent = true
        
        if let items = self.tabBar.items
        {
            for item in items
            {
                if let image = item.image
                {
                    item.image = image.withRenderingMode( .alwaysTemplate )
                    item.image?.withTintColor(getThemeColor())
                }
            }
        }
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        if let vc = viewController as? UINavigationController {
          
            //print("~~~~~~ pop controller: \(vc)")
           
            vc.popViewController(animated: false)
        }
    }
    
}



//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//
//        //print("~~~~~~ should select: \(viewController.nibName)")
//
//        return (viewController != tabBarController.selectedViewController)
//
//    }
